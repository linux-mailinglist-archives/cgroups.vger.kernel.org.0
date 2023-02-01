Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34EA686278
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjBAJIc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 04:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjBAJIY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 04:08:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19562252;
        Wed,  1 Feb 2023 01:07:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ha3-20020a17090af3c300b00230222051a6so1343180pjb.2;
        Wed, 01 Feb 2023 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyDJoRO+eavlOXGc4Q5SqoZUyZeya7RZ/BUKNVX/+dM=;
        b=n2kJU8RU6IvD/ch8vvXg1MhGLeamnUTDDdUpFRbfmE/2i6Ns4J1BaSL67JvbV163yV
         WLDUX8LreB1zUVzjU5huvP/DhUdx0OlMmaXyLeIqjQ20kONQkXYsh0nT6objM+1J9L9p
         TsXk8BbhOP4NR7MvpmjdH/b7f/HZLcE3nSk5xD196RrOLQcd9SoYhGIZQQ/PRx6gdqv+
         0JYWD1DjJul12kanXB2l9mLvaSkxRdWlMHuy6g5+8EfbeVNCEJVz9KpaScfTG6zbLTd+
         J8xEigI1i6MGnIcts/aAzTCezN5DIBtI1pbH7OcvOgofhi3tK4yNrr6W0Gh1TYgnTjTu
         WB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyDJoRO+eavlOXGc4Q5SqoZUyZeya7RZ/BUKNVX/+dM=;
        b=u+dL6zkycS5Vtt+rObBfs1ezkJeLTlyR/n8scL+kEwWZknsRzhKZkp01wHBMgYjCUI
         kB1wTy+R1QpYG3OdVVtuoa/W5spai2tS94/S35xZ3E7BuWUDrdRz28NNwdiEAiK5xhB8
         LDoYjlIqgVG3hOFiXpLGFnIyLPcVJvi1atn9YfG3BKDZJ34bedl9iouVOJMGlDMtkz23
         dq+sAkDbD81ojmHe/wh6sNjBNr0r8AHwNkzJ7e++XoYmA+kqSuvVIJ4vP1CMN6SsU92M
         JBLzWlYLNVT6sHhcvss4ZtK7XVHqw+U77LoGgUPJMpJ8biG+pRTY6CEXBAyKqNRdlwvY
         Dbig==
X-Gm-Message-State: AO0yUKU1NDSW6dMtSlcQEmW1eW1tj5qlbEBIE3YCPaVZXGI51uTSpHnX
        POEFrxGvNWNXoQpx083IKhI=
X-Google-Smtp-Source: AK7set9sYNzoDhM3lbLZDZLS4ZpRhW4FYff6fKjTlS1Ej2P5it/rfKiNfSxJmx6GlLRjg3DcvPuFyQ==
X-Received: by 2002:a17:90b:3812:b0:22c:24c0:7106 with SMTP id mq18-20020a17090b381200b0022c24c07106mr1447738pjb.21.1675242472898;
        Wed, 01 Feb 2023 01:07:52 -0800 (PST)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id e16-20020a633710000000b004efe1f24522sm1050777pga.23.2023.02.01.01.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:07:52 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id BEAED104F9E; Wed,  1 Feb 2023 16:07:48 +0700 (WIB)
Date:   Wed, 1 Feb 2023 16:07:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Message-ID: <Y9or5PkdXj/D94fR@debian.me>
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OS7Ho6/EPKDu6yfb"
Content-Disposition: inline
In-Reply-To: <20230201045227.2203123-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--OS7Ho6/EPKDu6yfb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2023 at 12:52:27PM +0800, Hou Tao wrote:
>  The following numerical values are associated with the I/O priority poli=
cies:
> =20
> -+-------------+---+
> -| no-change   | 0 |
> -+-------------+---+
> -| none-to-rt  | 1 |
> -+-------------+---+
> -| rt-to-be    | 2 |
> -+-------------+---+
> -| all-to-idle | 3 |
> -+-------------+---+
> +
> ++---------------+---------+-----+
> +| policy        | inst    | num |
> ++---------------+---------+-----+
> +| no-change     | demote  | 0   |
> ++---------------+---------+-----+
> +| none-to-rt    | demote  | 1   |
> ++---------------+---------+-----+
> +| rt-to-be      | demote  | 2   |
> ++---------------+---------+-----+
> +| idle          | demote  | 3   |
> ++---------------+---------+-----+
> +| promote-to-rt | promote | 1   |
> ++---------------+---------+-----+
> =20

The first row should have been header row:

---- >8 ----
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index e0b9f73ef62a9e..55f9b579716564 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2048,7 +2048,7 @@ The following numerical values are associated with th=
e I/O priority policies:
=20
 +---------------+---------+-----+
 | policy        | inst    | num |
-+---------------+---------+-----+
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+=3D=3D=3D=3D=3D+
 | no-change     | demote  | 0   |
 +---------------+---------+-----+
 | none-to-rt    | demote  | 1   |

> @@ -2064,9 +2074,13 @@ The numerical value that corresponds to each I/O p=
riority class is as follows:
> =20
>  The algorithm to set the I/O priority class for a request is as follows:
> =20
> -- Translate the I/O priority class policy into a number.
> -- Change the request I/O priority class into the maximum of the I/O prio=
rity
> -  class policy number and the numerical I/O priority class.
> +-- Translate the I/O priority class policy into an instruction and a num=
ber
> +-- If the instruction is demotion, change the request I/O priority class
> +-  into the maximum of the I/O priority class policy number and the nume=
rical
> +-  I/O priority class.
> +-- If the instruction is promotion, change the request I/O priority class
> +-  into the minimum of the I/O priority class policy number and the nume=
rical
> +-  I/O priority class.
> =20

Remove the excessive bullet list marker or the list above become paragraph
instead:

---- >8 ----
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 55f9b579716564..c3f16386c47bdf 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2074,12 +2074,12 @@ The numerical value that corresponds to each I/O pr=
iority class is as follows:
=20
 The algorithm to set the I/O priority class for a request is as follows:
=20
--- Translate the I/O priority class policy into an instruction and a number
--- If the instruction is demotion, change the request I/O priority class
--  into the maximum of the I/O priority class policy number and the numeri=
cal
--  I/O priority class.
--- If the instruction is promotion, change the request I/O priority class
--  into the minimum of the I/O priority class policy number and the numeri=
cal
+- Translate the I/O priority class policy into an instruction-number pair.
+- If the instruction is demotion, change the request I/O priority class
+  into the maximum of the I/O priority class policy number and the numeric=
al
+  I/O priority class.
+- If the instruction is promotion, change the request I/O priority class
+  into the minimum of the I/O priority class policy number and the numeric=
al
 -  I/O priority class.
=20
 PID

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--OS7Ho6/EPKDu6yfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9or3wAKCRD2uYlJVVFO
o58vAQD9CxSaIpA4AdTyvw0fuMNPOIuLSy4uqbVbnlwCHskJ8AD+IKwJnyzxD6Z5
kesBn69iDFNMECytC+QbcW0GkzPXZw0=
=iRGq
-----END PGP SIGNATURE-----

--OS7Ho6/EPKDu6yfb--
