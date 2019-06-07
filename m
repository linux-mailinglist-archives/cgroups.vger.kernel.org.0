Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB73841E
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2019 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFGGHy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jun 2019 02:07:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfFGGHx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jun 2019 02:07:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so668126wmm.1
        for <cgroups@vger.kernel.org>; Thu, 06 Jun 2019 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6xJ4Zi0fEzF1tamGyEeDu2gwAQnQnxhNg41rFECCkME=;
        b=j1kxod//g55v+aH9PBXXXCXwL4CPf5Z5ng1IQ85XBMkKZwUXVz5JzjKRrl3YV3MYHh
         5QEo9EtbKVWSFhvsQtEQ2knHJfp8/9EMq86MrSnhNT4HwGUG3qGK8yv1go7PKxIHtv8Z
         x5i7xnmgrN1ki+HZ7iA7v1Wph8U7c+hVnMbbx8KOCpC3fYGHojp59mY5/Aplw/ZA3Zxv
         85hT6g0MPadKGjRjBGVtxFU2sZ1brlAS8opEUswBxGegwMLqGXA3xzu3FJkTNxuzsfBT
         /Krk/5igaBPzGDw04EUyRZzCFNUIa8lEdQE8fzUlhyt1uPb2dsF2j9eWvylzbOPusXGo
         ShGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6xJ4Zi0fEzF1tamGyEeDu2gwAQnQnxhNg41rFECCkME=;
        b=Ug9TlVu3GUSK6fEWeohmSw9+8e4X/2imkiWhkcxgJXKiBUXCc/LuGDMNmY8ni+9akB
         DJk0WHvKC5WO2yT8wUvP3zlTCQvVNO/snkHNugJ/5MU0PadzJwdM6WANROsd9m3BGrUb
         BdYY3lmuya0yH6nHVMZGCLhlzhWsPdunmZiA+n+MmSfNsE4kcSpee2SDTU++e/UvXtDv
         xFdlvYTpms2NVoUJgqROiP4dofHztTGHEj7hCfb303sgqFirZ0W6vsGtMvDt4fdyGb2W
         LyHUgPdCIqI9IvO5cV4fhFxp8W3se0rtSIKUTH3OOJcmkXUDOteWH4vVYJk+zP+krS0R
         ZWvg==
X-Gm-Message-State: APjAAAWCJeNkQxUkbozKQk7kvCjA4+SJlSZM3sS3D9HkxytRnfEs9V9m
        CSZEQZKhHLwUpTwcsrRKU3aynQ==
X-Google-Smtp-Source: APXvYqwISqB3DmYuwmFsvD/7tOs53RmwCC1Gt1bRtzf4ND71VN50Ybj8wEoqZJLBWqG9rrbs3alEZA==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr2338221wmf.174.1559887670872;
        Thu, 06 Jun 2019 23:07:50 -0700 (PDT)
Received: from [192.168.0.102] (88-147-34-172.dyn.eolo.it. [88.147.34.172])
        by smtp.gmail.com with ESMTPSA id n7sm787465wrw.64.2019.06.06.23.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 23:07:50 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <3F21E6DF-2688-46A8-8A41-320BCBA86D05@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5E4D2C27-0D0A-4856-A512-45033AE94569";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 5/6] bfq-iosched: move bfq_stat_recursive_sum into the
 only caller
Date:   Fri, 7 Jun 2019 08:07:48 +0200
In-Reply-To: <20190606102624.3847-6-hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Christoph Hellwig <hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
 <20190606102624.3847-6-hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Apple-Mail=_5E4D2C27-0D0A-4856-A512-45033AE94569
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 6 giu 2019, alle ore 12:26, Christoph Hellwig <hch@lst.de> =
ha scritto:
>=20
> This function was moved from core block code and is way to generic.
> Fold it into the only caller and simplify it based on the actually
> passed arguments.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/bfq-cgroup.c | 62 ++++++++++++++--------------------------------
> 1 file changed, 19 insertions(+), 43 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index a691dca7e966..d84302445e30 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -80,47 +80,6 @@ static inline void bfq_stat_add_aux(struct bfq_stat =
*to,
> 		     &to->aux_cnt);
> }
>=20
> -/**
> - * bfq_stat_recursive_sum - collect hierarchical bfq_stat
> - * @blkg: blkg of interest
> - * @pol: blkcg_policy which contains the bfq_stat
> - * @off: offset to the bfq_stat in blkg_policy_data or @blkg
> - *
> - * Collect the bfq_stat specified by @blkg, @pol and @off and all its
> - * online descendants and their aux counts.  The caller must be =
holding the
> - * queue lock for online tests.
> - *
> - * If @pol is NULL, bfq_stat is at @off bytes into @blkg; otherwise, =
it is
> - * at @off bytes into @blkg's blkg_policy_data of the policy.
> - */
> -static u64 bfq_stat_recursive_sum(struct blkcg_gq *blkg,
> -			    struct blkcg_policy *pol, int off)
> -{
> -	struct blkcg_gq *pos_blkg;
> -	struct cgroup_subsys_state *pos_css;
> -	u64 sum =3D 0;
> -
> -	lockdep_assert_held(&blkg->q->queue_lock);
> -
> -	rcu_read_lock();
> -	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
> -		struct bfq_stat *stat;
> -
> -		if (!pos_blkg->online)
> -			continue;
> -
> -		if (pol)
> -			stat =3D (void *)blkg_to_pd(pos_blkg, pol) + =
off;
> -		else
> -			stat =3D (void *)blkg + off;
> -
> -		sum +=3D bfq_stat_read(stat) + =
atomic64_read(&stat->aux_cnt);
> -	}
> -	rcu_read_unlock();
> -
> -	return sum;
> -}
> -
> /**
>  * blkg_prfill_stat - prfill callback for bfq_stat
>  * @sf: seq_file to print to
> @@ -1045,8 +1004,25 @@ static int bfqg_print_rwstat(struct seq_file =
*sf, void *v)
> static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
> 				      struct blkg_policy_data *pd, int =
off)
> {
> -	u64 sum =3D bfq_stat_recursive_sum(pd_to_blkg(pd),
> -					  &blkcg_policy_bfq, off);
> +	struct blkcg_gq *blkg =3D pd_to_blkg(pd);
> +	struct blkcg_gq *pos_blkg;
> +	struct cgroup_subsys_state *pos_css;
> +	u64 sum =3D 0;
> +
> +	lockdep_assert_held(&blkg->q->queue_lock);
> +
> +	rcu_read_lock();
> +	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
> +		struct bfq_stat *stat;
> +
> +		if (!pos_blkg->online)
> +			continue;
> +
> +		stat =3D (void *)blkg_to_pd(pos_blkg, &blkcg_policy_bfq) =
+ off;
> +		sum +=3D bfq_stat_read(stat) + =
atomic64_read(&stat->aux_cnt);
> +	}
> +	rcu_read_unlock();
> +
> 	return __blkg_prfill_u64(sf, pd, sum);
> }
>=20
> --
> 2.20.1
>=20


--Apple-Mail=_5E4D2C27-0D0A-4856-A512-45033AE94569
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlz5/zQACgkQOAkCLQGo
9oMJ1g//Uq6rihqfY8N/SIZ5zFCHuk8eizqXtFV4p1MKbm84R2YUTOZWifce95vW
5R5XVD7mRQ2h4hzwDW1r7aE+reoCCAlCIGqXITUpT/e2PpUvRmY+6Wcs6Vwcd9vR
GfZjKIGqydgbxRfdBho352yUN+/QYJxR+XSkwVLzNQVKKuuzbGQFh3kafY/mjE1b
m1WoyOmUgjve+ui4TGyU5M3Mn3aRCSzoYWzIj1QyOqjgaFp9FFkFKGv46fu2C2zP
SGYbSvn+WuLxBhh+Wh8A0gDREuV7MyPyOVCZMA8VN7fCBykrCT6d6TKjTmc20WuY
7mT6MNFF0mom6dIX2spjTL0rnAdgKkRInwaI5RJm1fQXVVPZTm4hArKfK0Yl/68D
BM1kqYh2T8OLEiTQLCL5IRX844El11g/btmlNLlhBPeUeNkERe6CucSX0++UllA6
TREKdlmE1Jy/8uZKgCEgJpAOB8mCnU+MxrpXSGrY+V/iBtZt12R5M8nXLmWgiJ1p
xXPyvE5JMYg6xgAMTBO9mnBsTALF11WRQl9PVWdmOxWUFiZhRgzdp3zgpoaFAFjW
YAOxsLp2LY7iz7TT9KGoE/uN6rArHIVYnMTuzWfCv547wnwQXlYXaJBSSqKxEoj/
5P52zzCamgtxlKahQHQ/JJQcvRloGKFgZNm2N5igas9duc07e+o=
=25My
-----END PGP SIGNATURE-----

--Apple-Mail=_5E4D2C27-0D0A-4856-A512-45033AE94569--
