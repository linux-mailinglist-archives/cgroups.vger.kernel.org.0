Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936CF1A6ACC
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgDMRBe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732295AbgDMRBd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 13:01:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74ABC0A3BDC;
        Mon, 13 Apr 2020 10:01:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i10so10844446wrv.10;
        Mon, 13 Apr 2020 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Y+OjZtirFhjkKohAUaG6BdVWbAOuDBo2mD5OAId8HZs=;
        b=bhljM/45ZDJuZwpwJOb8QMjCZbnOZWPwXXJxlZtz0k8J78lyk63TMhqsI2IwWSibjY
         RID2Cm5+ZEN13Xg4k+c30cv4cJAtDvJacnIbjdsjzoNB0ZZ2O9lrbtipsk2xP7mNwmdr
         CMPnkCStQX4m84ySBmtfT9w2f9sA6d8L8pQFdfZ4CoihS06PKjWsQ4NO30P/boCyZa6T
         jrcw3BJ6mIc9KSEjPrtgpzdk91dpL/AWRXRegYPqD3i7TmEX+W6u8bAHhCRcQ3zgfEwF
         ClsJ9kncLd3QpUgx6qTFNScUmHL4unzU8Q1i/+BMwG1CWVhYoqL0T9Ls7vs1DJnYbJt5
         xqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Y+OjZtirFhjkKohAUaG6BdVWbAOuDBo2mD5OAId8HZs=;
        b=r47w7rR5h+H12sL16oLcZDA/Du3DrtvcnyBeVAjWFDQX+74PLtgqRN0SU7R8iWe2+A
         1dvwoonW26RcQADuQieKJg5Q8M8q1WD89iI1/3EBYm899Tg40KDSjEvSw9a4aoHpvrng
         /1tgTRXaobHCDkcMuie/EU1gLXgEZG5mtQU5DO8l2ByVaJO+deXiZOxjPXICXFGFTUSE
         fJ6CXvnhxxuTXJ76GsVurN1o3JmgBjuBWwo0N1i5tp3cCbD89BbRj2ubHuo8z2Wvks9r
         dZgp7DVCasKGNfkJna8tgoY3w3Kmh3nlEsjsTLReS7u8axeON+yvz2DcKBLbVZqfuiR8
         EWaw==
X-Gm-Message-State: AGi0PuaUUN44Q4H+HucioJyGJUhp4WfRLCe+uvvbcvLYE1b1NSKXSwIw
        dW46mIq1eIw5sLG0QN+Eojw=
X-Google-Smtp-Source: APiQypI9T8YXRsMySBlE238yvwAkH42wDN8DfS1TphylQPTaiG+dN9P9IJvuuprZXh4MbcrBMzk9Yw==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr8423368wru.174.1586797291380;
        Mon, 13 Apr 2020 10:01:31 -0700 (PDT)
Received: from [192.168.43.75] ([109.126.129.227])
        by smtp.gmail.com with ESMTPSA id t2sm8633601wmt.15.2020.04.13.10.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:01:30 -0700 (PDT)
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency
 target handling
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, ming.lei@redhat.com, bvanassche@acm.org
References: <20200413162758.97252-1-tj@kernel.org>
 <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Message-ID: <6f69d35c-c593-f140-c351-c7fd2c13069e@gmail.com>
Date:   Mon, 13 Apr 2020 20:00:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZESNvDEwJ4gUs6e0UsPpowCHJz6ut96Qf"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZESNvDEwJ4gUs6e0UsPpowCHJz6ut96Qf
Content-Type: multipart/mixed; boundary="YJcycZrC01yeR1rFUGN2cbIOj36u3pt4d";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
 josef@toxicpanda.com, ming.lei@redhat.com, bvanassche@acm.org
Message-ID: <6f69d35c-c593-f140-c351-c7fd2c13069e@gmail.com>
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency
 target handling
References: <20200413162758.97252-1-tj@kernel.org>
 <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
In-Reply-To: <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>

--YJcycZrC01yeR1rFUGN2cbIOj36u3pt4d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/04/2020 19:56, Pavel Begunkov wrote:
> On 13/04/2020 19:27, Tejun Heo wrote:
>> Changes from v1[1]
>>
>> * Dropped 0002-block-add-request-io_data_len.patch and updated to use
>>   rq->stats_sectors instead as suggested by Pavel Begunkov.
>=20
> rq->stats_sectors is set only when there is QUEUE_FLAG_STATS, see
> blk_mq_start_request(). I don't see blk-iocost requiring it. Did I miss=
 something?

And there is no reason to not initialise it unconditionally.

--=20
Pavel Begunkov


--YJcycZrC01yeR1rFUGN2cbIOj36u3pt4d--

--ZESNvDEwJ4gUs6e0UsPpowCHJz6ut96Qf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl6Umq0ACgkQWt5b1Glr
+6U03A/+I2I+IhvRJKZaVJ/TYjRLBm1UKE5ljXXgHE/tb96RkjvEh1NlKCGhNKn1
Sd/8fIT0QJW23aZVFUYPwVAYUKkzbmyhUX9bE2nYjq2A7OckDshVBvrKpjzVAH1w
8SBzWFKysTSAPdyGLN2V3/cRn8ioBAGTpZd57WQJs8668WYGKWgxovbrc/s/mkWx
jF9e8PN5ZYg24clRLMK+5T0Z3w5K2VwNitmCiGXzj8K8sxPNz/v6a6p/cpSNKfZ4
6eo+oOhg8o9wGRMiZtA2H9fE2wrY7xcg2sF8vLkvKq6pVz6yI29wk+FbLvQuYJYc
Uhjy0USJV2Mp4ErgLzGD2iZIicPgCQUZoTm5Jgqyp4NWJUoOAquULy1pSm8hYdiX
JOuDcKuo+7S/PMSDUwZiwUYAJfPScy/OxOrYiCiE5letmpty5JV1J79bZ32XGVyA
/dVFVHrTPz1sCAS1F/RMAsERwsa7uXg1DUPelQifAr1wGJ81bQMfrtGbCR4/QU2P
VsyuhDadwS22FmMX4eJKdsCLkAUOX8hhPj2TpDVgYrpB2O4i+hnruPp8oGcHeGsG
2zeMHq5Ld9Ma5rTXlXhUNANsHGRONkg0lWUEF5CJ5/ViwEbfCZ9Tqu3fKBv6sJ7t
NjrTqzZp5B4AdBb0AejSDIkmq4c9Y7tj102TsDs2vVFehf4p99w=
=39Mc
-----END PGP SIGNATURE-----

--ZESNvDEwJ4gUs6e0UsPpowCHJz6ut96Qf--
