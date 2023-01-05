Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C3765E87B
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjAEJ71 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 04:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjAEJ7E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 04:59:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F595017A;
        Thu,  5 Jan 2023 01:58:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso1533956pjf.1;
        Thu, 05 Jan 2023 01:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGriBr9FHpvs0SauQeUGJ1InK5l2j7/+3cssO4S/h24=;
        b=TolsQSFh6FHbuxIU2puCecqWwoajTx8yNv++zWEdF23ZhpClghzz0Bf2TFkzhKMFYX
         c4glMtxaBmOTKDkPOIK+wkCijRmQ+qvzCfJcMBVrji2ji+XFbRYfRiuRg5HH02Fc+bmJ
         d7gP9ytD+jTqYhIbN7urYGJHmMrJW9eyW67OJwoqrly2nOYpHO783tPb7nBZSnjLi4eL
         moHO5NNv4uKezk/s9/+FL3Nef3aFKd+Gmq8g3M81kz3y7eoMrda7WIijutzz//90n5jY
         8aJQ29RO88qRrsBNSN/NWjAFVTDxt3is7Jg04ZAtW1eh/T2JVOYoLAVTJ/Fr8879VV2L
         YB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGriBr9FHpvs0SauQeUGJ1InK5l2j7/+3cssO4S/h24=;
        b=boGefgkiY6ikF0TE1OznljiB1ggs2cWUHftYWBuS2IBPymFu7VPJOG8eYacq+5n1Bi
         iIa+f+x6KLYXPkwH6aGUK7LIDlXxJ+HFzD6pBRJ7yTZahK76+QWcKS+4N8ZPiWOFEfen
         arLKvz97HbgM2U6Mn+1SuU0h3pRWbZGZojuUMwY5kFwTZMC5dCWOwUZGQSjfkq7ID2pg
         FlmWLFnmYWfFOBonnV7WSCZzIHA3OuhnzXce2PPtmsqbMUjljxyRiEdsEZ+gUjOmOeFA
         2nY+lFKND7xmCKvUvtZh6p9KKiWT/+wx2OSPAIOngl5MxMRkPx4+tvRFWuFDRVElVxQ8
         jXmQ==
X-Gm-Message-State: AFqh2kp4aVelXIOLBWsnqjBXg7oRkCQETrNvW/cufurMQhmC0thNH1Cl
        b0aGWJu8DK4YY0mTQbWQBDQ=
X-Google-Smtp-Source: AMrXdXvqFaQ0HdabHWQrVo3C13E2sTMa8YorMl2RiQGEFZEKLDgEkMXL+OzDca0JMaecZBV3W5STvA==
X-Received: by 2002:a05:6a21:78a0:b0:a3:960e:7d0a with SMTP id bf32-20020a056a2178a000b000a3960e7d0amr78864978pzc.58.1672912725898;
        Thu, 05 Jan 2023 01:58:45 -0800 (PST)
Received: from debian.me (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id f26-20020aa7969a000000b0058103f45d9esm17522559pfk.82.2023.01.05.01.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:58:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 20CBA10447A; Thu,  5 Jan 2023 16:58:41 +0700 (WIB)
Date:   Thu, 5 Jan 2023 16:58:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH 00/10] docs: cgroup-v1: formatting improv for "Memory
 Resource Controller" doc
Message-ID: <Y7afUbFCdrHzebRO@debian.me>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
 <Y7XvS5LJK01lWq48@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p5biEVtF7dmtOC3S"
Content-Disposition: inline
In-Reply-To: <Y7XvS5LJK01lWq48@slm.duckdns.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--p5biEVtF7dmtOC3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2023 at 11:27:39AM -1000, Tejun Heo wrote:

> Patchset doesn't apply. Can you please rebase on top of linus#master and
> drop reference to the commit in -next?
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--p5biEVtF7dmtOC3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7afTAAKCRD2uYlJVVFO
o20CAP9agXmFSnMIIo3uAuVlbWnWPPFlhc+75GAJz7qxeDkyBQEAt2cQhrJpxceg
a5OPlyiPBkrdCN+5nsP55ULJSSo2MAc=
=vANI
-----END PGP SIGNATURE-----

--p5biEVtF7dmtOC3S--
