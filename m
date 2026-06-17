Return-Path: <cgroups+bounces-17034-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wkuDJUaUMmqA2QUAu9opvQ
	(envelope-from <cgroups+bounces-17034-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:34:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A2699BE3
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=I8wEw6y8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17034-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17034-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA32E3188A06
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB7402432;
	Wed, 17 Jun 2026 12:26:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB23FFF8E
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:26:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699177; cv=none; b=jQf1SAT2JsMai5ao2vSjnyoQjSPlnkDyXwMg+W1DRqG/ZPNZjdN5s3GWb11ZLHzT5anogle28agtqzFeN0uX0no+QeOvO8U8IS5lCySjrh3myI1GQNejnVPEOXWimVGZQYd4DCe2Tn6WBz7wCmXbGAiiNXAAIIb8+HLXBg10dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699177; c=relaxed/simple;
	bh=oaz3MeK8t59MilWFzgrN7JxYEFiRZHAVlA6cq0zb+U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT8HmA0QoUOjnFkz+X1BSR3d2H5toXV5iBPNaPwf9N2uUi2zHV/cK+CGCG8DvXvjibGif90xHTwnJ/yvbuAB8oznO+N/1RlJVbkAxjz45nnBZfKa1RyrmLUkmZcDPTmErnSdkNs2CPEYyAFItbQgzUpwNTcwBzrdawuN+l0f0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I8wEw6y8; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso37968505e9.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699172; x=1782303972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YBXCuE6tuFht3k3o9SLsq14tW7sWyyo0dU5FVc07Z8=;
        b=I8wEw6y8OeWlwrWo1LOrG8Lu+9huJ7uAuTaoWo7hud2L6bLkCs588HSUzd0ZtyCN1z
         ElsWQCo45qq1TMavK9xfSIUWzNWTeTepZ4jh/iZtiM4SOe64OggaKSdouw9loielihMQ
         IfmLbo0L2QDjXJ54F022cbEr5fNCeisqh5w/DF6bqZga7Dq9+nvnvDcqse48jRfKKusR
         RcKP4pMUF0M6lqb46lXrvsjMgPNlz2WXQThB7rvLzxUVWYYU++fMMibjznCV6nE2sf8q
         RLKm858BA3hUqRHh5qHqMG6uxR9UopErmW/xGEAR55cxdgm1FwdnYWYhT3byxae566KS
         hunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699172; x=1782303972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YBXCuE6tuFht3k3o9SLsq14tW7sWyyo0dU5FVc07Z8=;
        b=imn/k6FFbfsZ1WHp1vLjz1hs6Wul1CZcKSfubDYOTY9dq3Sp0v24hUnfQP1ogFFQ+r
         d9HM+my1samNdj1PC4XVRDqfhmb0H2vrFB3STwquDzaJC3fdpq+q7VHsb/+XziA67ciO
         6IoRXOKHBhZlBL8OpnRIOtQNUcKcCEc0RDsNxIBRBGFNedcCUOk+VB85F2yfpgWEleFr
         cCRSPAxbq6+rKNfvy4j27M8wu5dPkJta5n3vCipydOoYtAmoJcLPxVxm+XeRRM3agWGg
         2ydlMzABJLMLiv6WIzl/71lU/0sSJRC9ldpVZFQ38DnqY6OyU2W9vVWMpPl4Byi+mtz2
         2lAA==
X-Forwarded-Encrypted: i=1; AFNElJ/d3QI0GwmtcrF96ALKKl8EN6aAXnWrvpftMPZdLvJKdoLfoEdaZ2qv4PjKY5C5AxdzPAbnoQNx@vger.kernel.org
X-Gm-Message-State: AOJu0YyprRoDwbUqoxKx1KoSi6sX5J0/9/Ln/jz/ku1VjH6iya3/p1u3
	c6jEnP2eS5E22QIACRIv0iBrRl1SdTBe1ZNlAgONEaeDnSLaz5jmaY024dLGxmlI28Y=
X-Gm-Gg: Acq92OHtln6ZbGdUrDUfUsoiTKFM9NI44J4eTD949lfIzLfCQ7ScUmzfw+C/CpYIN+2
	+qarPC8EvsqMnJI1o9GNElbvbuaNR9pfpbcvzzezphai/w/H3f77/+4qUzryfgE14pS1RAsPLFG
	1ebItz9lUg9XC+TcETsQm4J78HUGZa1WytZsxXcxVEWr3ohSM3/79zjmQAOqIhNP0FAI6A1BozG
	hIMSIPOdoL5W4acJpmwfrYP2ub+k0Ff8XmMlCh1rksGrNMYxENUSQJRidWzTf2orBW9gfi32rq5
	Pah+aIG1zHnh2yqD/qnaUTnHYAu+ii3nlVx+/kuccowl2y9V9YnxmGrJ5pM8kyswqr2OVD4tCzR
	afSa90aBIdMlBDwm0wXWa6RuIT+QzPrCaB9E7i//4f/2yXSSW1/CQmQtExAsxKArgQhp1o1qL0z
	U9z8tyIccnMUbEcXkI4w==
X-Received: by 2002:a05:600c:8b43:b0:490:bbc4:76a6 with SMTP id 5b1f17b1804b1-4923341fdb8mr74870325e9.21.1781699171664;
        Wed, 17 Jun 2026 05:26:11 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa3abd0sm179575345e9.1.2026.06.17.05.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:26:11 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:26:09 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v7 8/8] selftests/cgroup: test_zswap: wait for
 asynchronous writeback
Message-ID: <ajKLmjRIjKTNKGTn@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-9-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhxkikwyiqml4ro5"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-9-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-17034-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,m:yosryahmed@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 062A2699BE3


--rhxkikwyiqml4ro5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 8/8] selftests/cgroup: test_zswap: wait for
 asynchronous writeback
MIME-Version: 1.0


On Fri, Apr 24, 2026 at 12:00:59PM +0800, Li Wang <li.wang@linux.dev> wrote:
> @@ -345,7 +366,10 @@ static int test_zswap_writeback_one(const char *cgro=
up, bool wb)
>  		return -1;
> =20
>  	/* Verify that zswap writeback occurred only if writeback was enabled */
> -	zswpwb_after =3D get_cg_wb_count(cgroup);
> +	if (wb)
> +		zswpwb_after =3D wait_for_writeback(cgroup, 5000);

We should have something like
	cg_read_key_long_poll(cgroup,
	                      "memory.stat",
			      "zswpwb",
			      0,
			      500,
	                      DEFAULT_WAIT_INTERVAL_US);
for this.

Although this also needs further change like (and respective adjustment):

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testi=
ng/selftests/cgroup/lib/cgroup_util.c
index a7b3380d88d77..c0511853db9c6 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -188,8 +188,8 @@ long cg_read_key_long(const char *cgroup, const char *c=
ontrol, const char *key)
 }

 long cg_read_key_long_poll(const char *cgroup, const char *control,
-                          const char *key, long expected, int retries,
-                          useconds_t wait_interval_us)
+                          const char *key, enum exp_op expected_op, long e=
xpected,
+                          int retries, useconds_t wait_interval_us)
 {
        long val =3D -1;
        int i;
@@ -199,7 +199,9 @@ long cg_read_key_long_poll(const char *cgroup, const ch=
ar *control,
                if (val < 0)
                        return val;

-               if (val =3D=3D expected)
+               if (expected_op =3D=3D EXP_EQUAL && val =3D=3D expected)
+                       break;
+               if (expected_op =3D=3D EXP_GT && val > expected)
                        break;

                usleep(wait_interval_us);
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/too=
ls/testing/selftests/cgroup/lib/include/cgroup_util.h
index 567b1082974c5..3e9bfb66cf5a9 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -19,6 +19,11 @@

 #define DEFAULT_WAIT_INTERVAL_US (100 * 1000) /* 100 ms */

+enum exp_op {
+       EXP_EQUAL,
+       EXP_GT,
+};
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
@@ -69,8 +74,8 @@ extern long cg_read_long(const char *cgroup, const char *=
control);
 extern long cg_read_long_fd(int fd);
 long cg_read_key_long(const char *cgroup, const char *control, const char =
*key);
 long cg_read_key_long_poll(const char *cgroup, const char *control,
-                          const char *key, long expected, int retries,
-                          useconds_t wait_interval_us);
+                          const char *key, enum exp_op expected_op, long e=
xpected,
+                          int retries, useconds_t wait_interval_us);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);

--rhxkikwyiqml4ro5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSXRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ahk/gEA8MFcY73q1d/mRp6IVc/w
CQOVsXy+oQ7vXkS8eyOailYBAKUGPqDDIcVYrCtsuMyhJ+LOoh7WKCiXRcrKQPNr
iBMI
=ROyv
-----END PGP SIGNATURE-----

--rhxkikwyiqml4ro5--

