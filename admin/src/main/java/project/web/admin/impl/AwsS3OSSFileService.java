package project.web.admin.impl;

import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Strings;
import kernel.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.compress.utils.FileNameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.core.waiters.WaiterResponse;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.services.s3.waiters.S3Waiter;

import java.io.*;
import java.net.URL;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.*;

/**
 * <p>
 * 亚马逊s3 OSS 文件存储服务
 * </p>
 *
 * @author shy
 * @since 2022-10-17
 */
@Slf4j
@Service
public class AwsS3OSSFileService {

    @Value("${oss.aws.s3.bucketName}")
    private String bucketName;
    @Value("${images.dir}")
    private String tempFilePath;

    /**
     * 获取操作客户端
     *
     * @return
     */
    private S3Client getS3Client() {
        ProfileCredentialsProvider credentialsProvider = ProfileCredentialsProvider.create();
        Region region = Region.US_EAST_1;
        S3Client s3 = S3Client.builder()
                .region(region)
                .credentialsProvider(credentialsProvider)
                .build();
        return s3;
    }

    /**
     * 创建存储桶
     *
     * @param bucketName
     */
    public void createBucket(String bucketName) {
        log.info("AwsS3OSSFileService createBucket bucketName:{}", bucketName);
        try {
            S3Client s3Client = getS3Client();
            S3Waiter s3Waiter = s3Client.waiter();
            CreateBucketRequest bucketRequest = CreateBucketRequest.builder()
                    .bucket(bucketName)
                    .build();

            s3Client.createBucket(bucketRequest);
            HeadBucketRequest bucketRequestWait = HeadBucketRequest.builder()
                    .bucket(bucketName)
                    .build();

            WaiterResponse<HeadBucketResponse> r = s3Waiter.waitUntilBucketExists(bucketRequestWait);
            log.info("AwsS3OSSFileService createBucket result :{}", JSONObject.toJSONString(r));
        } catch (S3Exception e) {
            log.error("AwsS3OSSFileService createBucket Exception", e.getMessage(), e.awsErrorDetails().errorMessage(), e);
        }
    }

    public static String policyText = "{ \n" +
            "  \"Version\": \"2012-10-17\",\n" +
            "  \"Statement\": [\n" +
            "    {\n" +
            "      \"Effect\": \"Allow\",\n" +
            "      \"Action\": \"s3:*\",\n" +
            "      \"Principal\": \"*\",\n" +
            "      \"Resource\": [\n" +
            "        \"arn:aws:s3:::%s/*\"\n" +
            "      ]\n" +
            "    }\n" +
            "  ]\n" +
            "}";

    /**
     * 设置存储桶策略
     *
     * @param bucketName
     */
    public void setPolicy(String bucketName) {
        log.info("AwsS3OSSFileService setPolicy bucketName:{},policyText:{}", bucketName, policyText);
        try {
            S3Client s3Client = getS3Client();
            PutBucketPolicyRequest policyReq = PutBucketPolicyRequest.builder()
                    .bucket(bucketName)
                    .policy(String.format(policyText, bucketName))
                    .build();
            PutBucketPolicyResponse r = s3Client.putBucketPolicy(policyReq);
            log.info("AwsS3OSSFileService setPolicy result :{}", r.toString());
            log.info("AwsS3OSSFileService setPolicy result :{}", JSONObject.toJSONString(r));
        } catch (S3Exception e) {
            log.error("AwsS3OSSFileService setPolicy Exception", e.getMessage(), e.awsErrorDetails().errorMessage(), e);
        }
    }

    /**
     * 获取文件访问链接
     *
     * @param bucketName
     * @param keyName
     */
    public void getURL(String bucketName, String keyName) {
        log.info("AwsS3OSSFileService getURL bucketName:{},keyName:{}", bucketName, keyName);

        try {
            S3Client s3Client = getS3Client();
            GetUrlRequest request = GetUrlRequest.builder()
                    .bucket(bucketName)
                    .key(keyName)
                    .build();
            URL url = s3Client.utilities().getUrl(request);
            log.info("The URL for  " + keyName + " is " + url);
        } catch (S3Exception e) {
            log.error("AwsS3OSSFileService getURL Exception", e.getMessage(), e.awsErrorDetails().errorMessage(), e);
        }
    }

    /**
     * 上传本地文件
     *
     * @return
     */
    public String putS3Object(String moduleName, MultipartFile file) {
        String fileType = FileNameUtils.getExtension(file.getOriginalFilename());
        String id = UUID.randomUUID().toString();
        String path = moduleName + "/" + LocalDate.now() + "/" + id + "." + fileType;

        log.info("AwsS3OSSFileService putS3Object bucketName:{},objectKey:{},objectPath:{}", bucketName, path, file.getName());
        try {
            Map<String, String> metadata = new HashMap<>();
            metadata.put("x-amz-meta-myVal", "test");
            PutObjectRequest putOb = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(path)
                    .metadata(metadata)
                    .build();
            S3Client s3Client = getS3Client();
            s3Client.putObject(putOb, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));
            return path;
        } catch (S3Exception e) {
            log.error("AwsS3OSSFileService putS3Object S3Exception", e.getMessage(), e.awsErrorDetails().errorMessage(), e);
            throw new BusinessException("文件上传失败");
        } catch (IOException e) {
            log.error("AwsS3OSSFileService putS3Object IOException", e.getMessage(), e);
            throw new BusinessException("文件上传失败");
        }
    }

    /**
     * 上传本地文件
     *
     * @return
     */
    public String putS3Object(String moduleName, MultipartFile file, Float quality) {
        String fileType = FileNameUtils.getExtension(file.getOriginalFilename());
        String id = UUID.randomUUID().toString();
        String path = moduleName + "/" + LocalDate.now() + "/" + id + "." + fileType;
        String thumbnailPath = moduleName + "/" + LocalDate.now() + "/" + id + "_thumbnail." + fileType;

        log.info("AwsS3OSSFileService putS3Object bucketName:{},objectKey:{},objectPath:{}", bucketName, path, file.getName());
        try {
            ByteArrayOutputStream bs = cloneInputStream(file.getInputStream());

            InputStream orgIS = new ByteArrayInputStream(bs.toByteArray());

            Map<String, String> metadata = new HashMap<>();
            metadata.put("x-amz-meta-myVal", "test");
            PutObjectRequest putOb = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(path)
                    .metadata(metadata)
                    .build();
            S3Client s3Client = getS3Client();
            s3Client.putObject(putOb, RequestBody.fromInputStream(orgIS, file.getSize()));

            InputStream thumbnailIS = new ByteArrayInputStream(bs.toByteArray());

            File tempFile = new File(tempFilePath + "/temp-img/");
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            Thumbnails.of(thumbnailIS).scale(1D).outputQuality(quality).toFile(tempFilePath + "/temp-img/" + id + "_thumbnail." + fileType);

            PutObjectRequest putThumbnailOb = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(thumbnailPath)
                    .metadata(metadata)
                    .build();
            File thumbnailFile = new File(tempFilePath + "/temp-img/" + id + "_thumbnail." + fileType);
            s3Client.putObject(putThumbnailOb, RequestBody.fromInputStream(Files.newInputStream(thumbnailFile.toPath()), thumbnailFile.length()));
            return path;
        } catch (S3Exception e) {
            log.error("AwsS3OSSFileService putS3Object S3Exception", e.getMessage(), e.awsErrorDetails().errorMessage(), e);
            throw new BusinessException("文件上传失败");
        } catch (IOException e) {
            log.error("AwsS3OSSFileService putS3Object IOException", e.getMessage(), e);
            throw new BusinessException("文件上传失败");
        }
    }

    private static ByteArrayOutputStream cloneInputStream(InputStream input) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len;
            while ((len = input.read(buffer)) > -1) {
                baos.write(buffer, 0, len);
            }
            baos.flush();
            return baos;
        } catch (IOException e) {
            log.error("cloneInputStream IOException", e.getMessage(), e);
        }
        return null;
    }


    /**
     * 判断文件是否为图片
     *
     * @param fileName
     * @return
     */
    public boolean isImageFile(String fileName) {
        List<String> imgTypes = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp");
        if (Strings.isNullOrEmpty(fileName)) {
            return false;
        }
        String fileType = FileNameUtils.getExtension(fileName);
        return imgTypes.contains(fileType.toLowerCase());
    }
}
