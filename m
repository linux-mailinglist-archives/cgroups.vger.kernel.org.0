Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807ED5257EB
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 00:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359256AbiELWnI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiELWnH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 18:43:07 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6C283A00
        for <cgroups@vger.kernel.org>; Thu, 12 May 2022 15:43:06 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id jt15so5474157qvb.8
        for <cgroups@vger.kernel.org>; Thu, 12 May 2022 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sK+42GruGIvOT2IVl/tBK2BbAhxfazwDQIwVMlz/Dqg=;
        b=H42oGBBaIuWQozoExGdZVqBqIqAeAaw0VcEwB7+tdbA3RWDWl13l18u2+dRaIYLUMR
         Amb5ZOM2foKYxqovgtqo1tjnZDrnFvQNV1oDRcFrwKyHcbHxr8IYILHu8cFE+/FwdgJ+
         k1QzqMdFo1CH9LqrY/N5oJ6VwsMQbBXbOquIXVKBKz7OMvicItrTul+UwYGfK0oXe0b3
         MFbnWkQ1UXockxsuTx+Syh8gAkbxHgcDoLNBLgy3ffLJbIj7j3jIoH9z6F84++WQoIQS
         pHJSx+o0sR4pV8Acp680iGiHSsIrorvrQbvKKDyArgj8eNhOeiD6fVY6QDzo/UoKdaOu
         wDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sK+42GruGIvOT2IVl/tBK2BbAhxfazwDQIwVMlz/Dqg=;
        b=SUDdRdj3s7bCpwlKiGxC34VRnO29wSYvPoHkydBBV+ZcYi8pTxg3HZWY9P4WME54im
         47FbN50wvd+9gqI2KoLYi0x/ZbblOXND9Hn2xamikD47FhiplbE8aezrrzR9WFX94GEi
         MgNXpLNlaYAtmxXMRNALa3ciQS9mq7duJyQ8IyAplxFIEjezILfpRgrU6/dI2OjkAhFG
         XUZguI6JcNolvGeaEYSAUsKxfKX1rtfE6xXqHxzUGYXL58GljXxLZW/DNg047qGLHUCI
         hBhFUBJX6x6NlofzxyUr5V65zarqjE0iVS/ALSKI0PDozTkVx8bsTSYSHbFL7fcg1bEc
         Uz8w==
X-Gm-Message-State: AOAM530Tl60WYoWCcHCqQrIZ5qWVflynLuL+itoz4Usu91A9Eaok0Jpm
        eVKo0Vb0CBNNdp5mgrcQlGglyaRGfdQVNyBpptVzHw==
X-Google-Smtp-Source: ABdhPJxYK7yxziz6F+yn4V15rS5ApGuIGP6NpeLhq7Jxvm4/UQIKUmZ1iQYob5gt2XyqODVQvpRVU70EBpTXandwHvA=
X-Received: by 2002:a05:6214:250b:b0:45b:9ee:730a with SMTP id
 gf11-20020a056214250b00b0045b09ee730amr1970135qvb.15.1652395385318; Thu, 12
 May 2022 15:43:05 -0700 (PDT)
MIME-Version: 1.0
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Thu, 12 May 2022 15:42:54 -0700
Message-ID: <CACGdZYK3iLc8u+YuyteaWqLRCHUJvR10Gem6MFyx36wP4Z2y2Q@mail.gmail.com>
Subject: Issue with 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, w.bumiller@proxmox.com,
        cgroups@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000013f9805ded8481a"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--000000000000013f9805ded8481a
Content-Type: text/plain; charset="UTF-8"

I can see in the latest tip, if we have devices with no statistics,
we'll print the maj:min and then nothing else, which can end up
looking weird, (e.g. like below.) I see that in older kernels, we
avoided printing the device name at all if there were no stats, and it
looks like this behavior was silently broken by 252c651a4c85
("blk-cgroup: stop using seq_get_buf"), where before we prepared the
whole line then decided at the end whether to commit it or not.

I do see a patch "blk-cgroup: always terminate io.stat lines" that
addresses this by just unconditionally printing the newline (though it
looks like that patch never landed). I'm wondering if it's worth
trying to bring back the old behavior of not printing these devices at
all if they have no statistics. (e.g. by having the "first"
stats-haver writing out the bdev name, or going back to scnprintf)

9:0 8:0 rbytes=16720896 wbytes=905216 rios=768 wios=67 dbytes=0 dios=0
1:15 1:14 1:13 1:12 1:11 1:10 1:9 1:8 1:7 1:6 1:5 1:4 1:3 1:2 1:1 1:0

--000000000000013f9805ded8481a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNQwggO8oAMCAQICEAFEftjde/YEIFcjUXqh
cBUwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjAzMTUw
MzQ4MTFaFw0yMjA5MTEwMzQ4MTFaMCIxIDAeBgkqhkiG9w0BCQEWEWtoYXpoeUBnb29nbGUuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnSc4QiMo3U8X7waRXSjbdBPbktNNtBqh
S/5u+fj/ZKSgI2yE4sLMwA/+mKwg/7sa7w5AfZHezcsNdoPtSg+Fdps/FlA7XruMWcjotJZkl0XU
Kx8oRkC5IzIs4yCPbKjJjPnLLB6kscJHeFsONw1dB1LD/I/mXWBMVULRshygEklce7NMMBEgMELQ
HA8prVkASBCQcTBI9b1/dCaMkqs1pbI1S+jMQDPTVqJ6yHssJtwELHTH1ObZwi2Cx3q60b0sXYS0
18OjY3VYaZUXTOSFP5PN/OmbGt2smYKKCLujb0wJm06bFotBaJhVw5xdMAfCD+2cPvmYXDCF+7ng
AYBCcQIDAQABo4IB0jCCAc4wHAYDVR0RBBUwE4ERa2hhemh5QGdvb2dsZS5jb20wDgYDVR0PAQH/
BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAdBgNVHQ4EFgQU8bNUGSaYlhLY
h3dPtFviTyG11HYwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAE0ANr7NUOqEcZce4KYP
SjzlrshSC8sgJ8dKDDbe35PL86vDuMIrytVjiV10p/YUofun9GeHBY6r5kTyh4be5FgftiiNtWzn
U1W5cxLYMT1hKYxXxnM2sWMQGFl4TkxxbRoVZa3ou/NxFdAZeiQSwGnzk5oIDTBZQc8q3wMa1svm
A5Rd4MVaIUt+hyk6seAldN6k4/O34O1l2V6D+/BwagyzLWvOeMEM9hClVF+F6a20yy4dcDsprFZZ
Sk9JzUy9F6FM7L1wT2ndjTNDja4Y2tixf31KuisZLGKmDZsW/fXF1GgWDaM0DbYJwtE3kHylWnMk
CN4PfYgIa15C5A9lXhExggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAFEftjde/YEIFcjUXqhcBUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHDsP3BX
jy6RwT4vXBH4G8jwnka+73wWStMiGd08D4zQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDUxMjIyNDMwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/M8a2/yZZVUXuHOn8EDYZ0hBf
cGKPEt/aEPEZyza35hwKNlDHzu7MwKSxCdEKjsx6OiJrZtwv9sYxQI6sRKTxFbwcb/7lNA4X97jp
zBoy59ik1Y4Iex0mr7ZrnL45nZzvu/noKP3mM2iD7VEQg9qzYdpLz162rh389KLuzsvNqABgG8vR
IyAbEMSfxRLOk3J0/BhJD9UmtwCNWyIUZzAssFCmMmr+muT9r9Skxsk8VWYyAlu4mBWSqInTCJzM
AQXQ/mkdSF9Ts51hxktHWJtnhClHfUTohJl2ktb11nTJmS7qkep0ZhdUj4Zg9xoMfLNj688HaExD
yBGkJ1wg/2KO
--000000000000013f9805ded8481a--
