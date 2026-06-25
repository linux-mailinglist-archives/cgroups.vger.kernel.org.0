Return-Path: <cgroups+bounces-17297-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EGdBHLaNPWof4AgAu9opvQ
	(envelope-from <cgroups+bounces-17297-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 22:21:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A946C87BB
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 22:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=himj4Fqe;
	dkim=pass header.d=redhat.com header.s=google header.b=nW9rw2dv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17297-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17297-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751343062F50
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C6349CC4;
	Thu, 25 Jun 2026 20:20:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE9363C7F
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 20:20:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418848; cv=pass; b=Y8EycAJM3kyz1cu3aRJKbkzzdhQ8MmHNWK/BiyGqLJBzfbwzd8P/MUUQegNopUyJeq3RqkeFvds9iYrl0t+qPRFr6bUQ+GQbXX9DhyrMsrJc8y+j4fWp4QtGJwakDGijWISXZSMou2AI/fQ3OmLao8cdmol1TVp6EVUXERCbyio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418848; c=relaxed/simple;
	bh=p/iSApopAQ3Rwu8YiVTide2S0Vlj30HQ4DO34T4rOOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OK+jOsl1Mibe1srpLgLDv2a7l94Sv3YeXm5XLdg4ikEP85HcITBfXE7m1frzdAa1LLaRjgJJvzhTfKqAxyuHy/asGVSC3x5m4obvloEb43UpRtv8B0NDJvra+N8CjE7HKfYxpp6BeITjSyzlPDC9uKceRpB0V3F2h5d/toO8Xt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=himj4Fqe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nW9rw2dv; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782418844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9smn6tBX9r8BEBMzWgVsnmCOgRodWWhLzrgqGf3QyjE=;
	b=himj4FqetWzIsQrFkeCy+EPc0t5+BHf3MgG2aQz/gn+uRohTLSJ3qdGu5kJGce3J4I5aTM
	A0vVGTShElrMdKn4oxHbd7+hz3AHaprZSOCSf6h2Kn23sdJIpi6mgFa5yv9+VUuCsftgs5
	Fp6FzaYKuPUMXodgqapo597H9IFbXbg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-7JVamRAbMBmNdX0QkGLTlg-1; Thu, 25 Jun 2026 16:20:43 -0400
X-MC-Unique: 7JVamRAbMBmNdX0QkGLTlg-1
X-Mimecast-MFC-AGG-ID: 7JVamRAbMBmNdX0QkGLTlg_1782418842
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c0793772071so16748366b.0
        for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 13:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782418842; cv=none;
        d=google.com; s=arc-20260327;
        b=FeKqaeDl0gcC83+tOAcvwjRUYnE8X3gfyRIL119+JRHqZnkUbtiTKUZPwYkjTw2T0Q
         zut/cnhFEn5MwsrvxkDYmH0jXILbjRWesUdDIr/jWInEKWe/sU97qgYtM0E92CgXM0xF
         Tti5DsJfVLkUPStDv8FWJVKn2wQqktu+Wz5VtT5AOmw8qzl2sY3CaXk25nhcRv0arN6l
         jUSLgv4mhkmRV4LM67MnIej9ds4nYCHmL2Cp6Px+rKu430BWO/tLHQ5VRw+PUilgZ1f8
         abJ/KMBBliNOQM6gQbJftXOfSUDhaDKYMY/QVEYfYTWV9r3XLJKaVhx4GQNutZv1+18P
         Obhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9smn6tBX9r8BEBMzWgVsnmCOgRodWWhLzrgqGf3QyjE=;
        fh=qNd5LJ1oJphR5d8aLkdZn90yZDAWUZ7tb9TqaoxpnI0=;
        b=IK0Hb0tzxuB3Iya6CJwpCb/47EB3mX47oIHE/Q2OmfK6Q745/ngLK96D3IkxdClWG6
         Je4AwWoto0psnPGvFWxX9KWH1h0jh+kGTEy5ayGJBzJRVqDDYPiAkxcIpseTH5zZwsRK
         PjY+FLhswvSJp5ItFGkIqGrDsP+kL51DrO8kVvrpBuyBXxHTajVm8Qwlff9pd0HHsno6
         YvzDMH5LCqbg3EvobYH1bcBt22XPZcaUQcmV3Z5f257z4bITB1eMbMpKxRAXbSHPwkh6
         uar9D5FDxIv5jZgCUvGMGclVHnbE2tK4weAGxO6wYmdrBzS66DG42GibjRk3vEd6Zvwx
         jPSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782418842; x=1783023642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9smn6tBX9r8BEBMzWgVsnmCOgRodWWhLzrgqGf3QyjE=;
        b=nW9rw2dvOFRW/IUzPJ6TI3rRBlTusGN22zJCAlaxWzO+43Mdx4xj6TuCtFzxe1yqBV
         hoUdRaeNVL0X0D22QR20xjBtdDkd6aUYQZqnxRLcsb1WjTKrD/UgtX/k8xCQ2ec7c/y1
         Jg+25hHUbVi6tE+cgrjjb7gQ2+DmcmVf5pHd0Ji7qqisv1WfqjHiIMz1CrjqXbAnn5CU
         FSb55j+www+kZ6QNumX4dF1FqYFspDxhHjb98GKRGvr99LJzeKichechTqhMuPp13Jzf
         YLu539smdodBUcBdrzbZvJQOYGIGDM38p/LGxy5JhAW7/doyTLXGcIDhdSTNBNxJnhiH
         aQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782418842; x=1783023642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9smn6tBX9r8BEBMzWgVsnmCOgRodWWhLzrgqGf3QyjE=;
        b=bfsfWjw1ZxGfXmSZ2ga0aGM1zyZgUIVMqYpTv9fiD+QJPUFqiHwWUMtUnBKku8YORb
         r9O3eNnhS4ipCUiCQCC/yAqldBo0nV9yh9QFHFEew0ghcYDLUthkH2GuXcrSji5ygxUQ
         4Y4BpQnVqMdqTG9UR6wMwVdeSkxPLF7rzRLE98zysNCl3RUGsIr1092c7zvNAEQ9kAON
         06wTz875jqnfQmhdHmiJpoHy2hKvscdIYhrGWZRRuwT/CRYCrHivOvv57tREN2m7UL9s
         BjYbjRpixuvYJpMZOUricd81c/XOcXvlO8es+gRiyqHgGjAslb6L58I/Bqn82Wb57f9t
         AIYw==
X-Forwarded-Encrypted: i=1; AHgh+RrAkL+3wCw97tNhTPsX5c66af3RloPRy704hIlobH3nlai/OICUYL4UKPCVGVH4KWNa9Ydvi8e/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xvdw4MISctGF2mfuDvdQVLwIG/giqYOXXqWwpIc6KAotsc7i
	S2ofkiwPOO/94Za3Fu9SiFoMoAoFEFvBp/bcCxpsQ8S7/gWyF1PLMdt4bQ5Sj0aIvMa7QA8w8MC
	0PjdfRQbQuDnpPIwbJ2tc7SYpCsMELvR/glNRDuDzi6FVH1QyqRDehrxMhlgrrRXcTW0uX5xUW+
	O7Q+NtnZekSFikZxW3JZj2nsVw5rgd/0T0FQ==
X-Gm-Gg: AfdE7ckIjcviX/DieovXUmW6i6TGqt6EPXcv805aSHUtHt+A9UoOya7kewn5wR+CBys
	6vW/W00aDjm0d+psTBJLvwDFrXWC/hGl8PA18grb4jYBF9lynZyeWHSYCbLcqYSbMTheouMre25
	Lp4UzLAyBfXhJ3j4C7GSIzUbJAVTe7ft3kCb6+lR2/evoXHHhTj/zArmi1AFyXVShSY18=
X-Received: by 2002:a17:907:3c8b:b0:c12:10cb:f3d2 with SMTP id a640c23a62f3a-c1210cbf56emr188874566b.8.1782418842189;
        Thu, 25 Jun 2026 13:20:42 -0700 (PDT)
X-Received: by 2002:a17:907:3c8b:b0:c12:10cb:f3d2 with SMTP id
 a640c23a62f3a-c1210cbf56emr188871166b.8.1782418841669; Thu, 25 Jun 2026
 13:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625195415.1102409-1-joest@redhat.com>
In-Reply-To: <20260625195415.1102409-1-joest@redhat.com>
From: Joe Simmons-Talbott <joest@redhat.com>
Date: Thu, 25 Jun 2026 16:20:25 -0400
X-Gm-Features: AVVi8CfzErqpSrYpFNh6HJh7HgdbzLx0r2Noyaud5h0mBLZFo8stK9QwxwigB8s
Message-ID: <CAAQBMsPXjFGbQFa3ufvDDHxjgdj+5_kD0PLGD7vn19YNsEV_Kg@mail.gmail.com>
Subject: Re: [PATCH v4] selftests/cgroup: Adjust cpu test duration based on HZ
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Guopeng Zhang <zhangguopeng@kylinos.cn>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Li Wang <li.wang@linux.dev>, 
	Sebastian Chlad <sebastianchlad@gmail.com>, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cui.tao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17297-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:nphamcs@gmail.com,m:zhangguopeng@kylinos.cn,m:shakeel.butt@linux.dev,m:li.wang@linux.dev,m:sebastianchlad@gmail.com,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kylinos.cn,linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6A946C87BB

On Thu, Jun 25, 2026 at 3:54=E2=80=AFPM Joe Simmons-Talbott <joest@redhat.c=
om> wrote:
>

+mailing lists
+Tao Cui



> For lower HZ values a quota of 1000us is much lower than the amount
> of microseconds per tick which makes the tests test_cpucg_max and
> test_cpugc_max_nested fail. Increase the test duration to accommodate
> for lower HZ values.
>
> Link: https://lore.kernel.org/lkml/20260624160358.430354-1-joest@redhat.c=
om/
> Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
> ---
> v3 -> v4:
> - Use usec for adjusting test duration for better accuracy.
> - Remove underscore from static function
> - Use 1000 as the fallback value for hz since it's the default.
>
> v2 -> v3:
> - Instead of changing cpu.max quota extend the test duration based on
>   the HZ value.
> - don't call pclose() if popen() fails.
> - check return value of fscanf().
>
> v1 -> v2:
> - Try checking /proc/config.gz to get the actual kernel HZ value and
>   fallback to 1000 if the value cannot be determined.
>
>  .../cgroup/lib/include/cgroup_util.h          |  1 +
>  tools/testing/selftests/cgroup/test_cpu.c     | 47 ++++++++++++++++---
>  2 files changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/t=
ools/testing/selftests/cgroup/lib/include/cgroup_util.h
> index febc1723d090..8ebb2b4d4ec0 100644
> --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> @@ -8,6 +8,7 @@
>
>  #define MB(x) (x << 20)
>
> +#define NSEC_PER_USEC  1000L
>  #define USEC_PER_SEC   1000000L
>  #define NSEC_PER_SEC   1000000000L
>
> diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/se=
lftests/cgroup/test_cpu.c
> index 7a40d76b9548..1f280c1db68a 100644
> --- a/tools/testing/selftests/cgroup/test_cpu.c
> +++ b/tools/testing/selftests/cgroup/test_cpu.c
> @@ -639,6 +639,31 @@ test_cpucg_nested_weight_underprovisioned(const char=
 *root)
>         return run_cpucg_nested_weight_test(root, false);
>  }
>
> +/*
> + * Best effort attempt to get the kernel's HZ value from the config.
> + * Return the HZ value if found otherwise return 1000 (the default) to
> + * indicate failure.
> + */
> +static long
> +get_config_hz(void)
> +{
> +       long hz =3D 1000;
> +       FILE *f;
> +       char cmd[256] =3D "zcat /proc/config.gz 2>/dev/null | grep '^CONF=
IG_HZ=3D'";
> +
> +       f =3D popen(cmd, "r");
> +
> +       if (!f)
> +               return hz;
> +
> +       if (fscanf(f, "CONFIG_HZ=3D%ld", &hz) =3D=3D EOF)
> +               goto out;
> +
> +out:
> +       pclose(f);
> +       return hz;
> +}
> +
>  /*
>   * This test creates a cgroup with some maximum value within a period, a=
nd
>   * verifies that a process in the cgroup is not overscheduled.
> @@ -646,15 +671,20 @@ test_cpucg_nested_weight_underprovisioned(const cha=
r *root)
>  static int test_cpucg_max(const char *root)
>  {
>         int ret =3D KSFT_FAIL;
> +       long hz =3D get_config_hz();
>         long quota_usec =3D 1000;
>         long default_period_usec =3D 100000; /* cpu.max's default period =
*/
>         long duration_seconds =3D 1;
>
> -       long duration_usec =3D duration_seconds * USEC_PER_SEC;
> +       long duration_usec, duration_sec, duration_nsec;
>         long usage_usec, n_periods, remainder_usec, expected_usage_usec;
>         char *cpucg;
>         char quota_buf[32];
>
> +       duration_usec =3D duration_seconds * USEC_PER_SEC * 1000 / hz;
> +       duration_sec =3D duration_usec / USEC_PER_SEC;
> +       duration_nsec =3D duration_usec % USEC_PER_SEC * NSEC_PER_USEC;
> +
>         snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
>
>         cpucg =3D cg_name(root, "cpucg_test");
> @@ -670,8 +700,8 @@ static int test_cpucg_max(const char *root)
>         struct cpu_hog_func_param param =3D {
>                 .nprocs =3D 1,
>                 .ts =3D {
> -                       .tv_sec =3D duration_seconds,
> -                       .tv_nsec =3D 0,
> +                       .tv_sec =3D duration_sec,
> +                       .tv_nsec =3D duration_nsec,
>                 },
>                 .clock_type =3D CPU_HOG_CLOCK_WALL,
>         };
> @@ -710,15 +740,20 @@ static int test_cpucg_max(const char *root)
>  static int test_cpucg_max_nested(const char *root)
>  {
>         int ret =3D KSFT_FAIL;
> +       long hz =3D get_config_hz();
>         long quota_usec =3D 1000;
>         long default_period_usec =3D 100000; /* cpu.max's default period =
*/
>         long duration_seconds =3D 1;
>
> -       long duration_usec =3D duration_seconds * USEC_PER_SEC;
> +       long duration_usec, duration_sec, duration_nsec;
>         long usage_usec, n_periods, remainder_usec, expected_usage_usec;
>         char *parent, *child;
>         char quota_buf[32];
>
> +       duration_usec =3D duration_seconds * USEC_PER_SEC * 1000 / hz;
> +       duration_sec =3D duration_usec / USEC_PER_SEC;
> +       duration_nsec =3D duration_usec % USEC_PER_SEC * NSEC_PER_USEC;
> +
>         snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
>
>         parent =3D cg_name(root, "cpucg_parent");
> @@ -741,8 +776,8 @@ static int test_cpucg_max_nested(const char *root)
>         struct cpu_hog_func_param param =3D {
>                 .nprocs =3D 1,
>                 .ts =3D {
> -                       .tv_sec =3D duration_seconds,
> -                       .tv_nsec =3D 0,
> +                       .tv_sec =3D duration_sec,
> +                       .tv_nsec =3D duration_nsec,
>                 },
>                 .clock_type =3D CPU_HOG_CLOCK_WALL,
>         };
> --
> 2.54.0
>


