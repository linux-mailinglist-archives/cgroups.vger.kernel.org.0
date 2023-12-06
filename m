Return-Path: <cgroups+bounces-862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F3806CBB
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAAB1C209B4
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8113034E;
	Wed,  6 Dec 2023 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd5ilIFE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4EA4;
	Wed,  6 Dec 2023 02:55:13 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4302714a12.3;
        Wed, 06 Dec 2023 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860113; x=1702464913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVR7pUQEG31iVUA6cUrPPhiUlLhN1EKerFQpUeOEhog=;
        b=Gd5ilIFE4uXRWCXECZ+y9gk8maLrBJ0AdVT7ZVwx1VhCSxVjDXYd/STQMo/sP//+jG
         nXTx1APQtGy8/retsCSItnFgTqQMNFLJp0tul5AYfyhrKI5skEWPJVCHdVcnsIH4Y/ar
         G7W08bwN0CMSv9c36mWOadsxrTMD6hGGxxJhfpWEL3fI/Ivx6k2nUWtQ4lI/f89BiHzv
         vqlECT05LT1SmFDapcez2p6nVMCIcggjNfzlCf7gu4t4EwvuSBm2zoYogh84e9DqtRu1
         W0zqoWM2CcHXhtPWC15ZmmU6ryAxXQTr+5MK+jbsR1aEsm/6AEURh1F+Qbjhe/CNJa9G
         HgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860113; x=1702464913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVR7pUQEG31iVUA6cUrPPhiUlLhN1EKerFQpUeOEhog=;
        b=c9/kabUzYPtHN2Ccap+vnYZ42GTaPEDH6ot5MlEpUezZ5zobIxGNyp3WnAQTZX6eUh
         V4B4yNi8ogHs2A1a3bOZUCslOR9SS1kawNqQtQBHSCPc/KVlMVjg1sTTCGSWxBohajc/
         RBtjUc6s22mpx3Q4N66g4f2WWI7WrqVPrXCMyVJP0cGqNODvde5oDMS3JSvUYxLX1SCL
         hmAVZPBafBbwtjQBA9PksxmvgA8XR1k61pBfyHOG7wq/0vpcpXHtASlvy5rzIpXqnH/c
         3AOhQ9wuwpQNhtGnaQKbOkRo1gMKzoETdRMGlb/aKV8YS2vEx7PNSr/G3ImHCExzq92E
         Y89Q==
X-Gm-Message-State: AOJu0YyMe8XiVr555xBIPNmoDq/6/XfSgbI7u7n1yD0PBPj9KHUrVQFz
	E6r1nRorPLSh4NFKSisDsfs=
X-Google-Smtp-Source: AGHT+IESses2OjCKH8DRICbCXlwOPOIHyhoN8Q/4BmDcufBDXhskt81/WbSakD3Cag1iV+W2ROrNyA==
X-Received: by 2002:a05:6a21:7891:b0:18f:e3fb:8cf2 with SMTP id bf17-20020a056a21789100b0018fe3fb8cf2mr271957pzc.84.1701860112787;
        Wed, 06 Dec 2023 02:55:12 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006ce41b1ba8csm6153534pfb.131.2023.12.06.02.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:55:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 4EA0210418A9B; Wed,  6 Dec 2023 17:55:09 +0700 (WIB)
Date: Wed, 6 Dec 2023 17:55:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Linux CGroups <cgroups@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>
Subject: Re: [PATCH-cgroup v2] cgroup/cpuset: Include isolated cpuset CPUs in
 cpu_is_isolated() check
Message-ID: <ZXBTDZtbpOZlooea@archie.me>
References: <20231205222114.773446-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7yiVXI7aBtIVC8K1"
Content-Disposition: inline
In-Reply-To: <20231205222114.773446-1-longman@redhat.com>


--7yiVXI7aBtIVC8K1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 05:21:14PM -0500, Waiman Long wrote:
> Currently, the cpu_is_isolated() function checks only the statically
> isolated CPUs specified via the "isolcpus" and "nohz_full" kernel
> command line options. This function is used by vmstat and memcg to
> reduce interference with isolated CPUs by not doing stat flushing
> or scheduling works on those CPUs.
>=20
> Workloads running on isolated CPUs within isolated cpuset
> partitions should receive the same treatment to reduce unnecessary
> interference. This patch introduces a new cpuset_cpu_is_isolated()
> function to be called by cpu_is_isolated() so that the set of dynamically
> created cpuset isolated CPUs will be included in the check.
>=20
> Assuming that testing a bit in a cpumask is atomic, no synchronization
> primitive is currently used to synchronize access to the cpuset's
> isolated_cpus mask.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/cpuset.h          |  6 ++++++
>  include/linux/sched/isolation.h |  4 +++-
>  kernel/cgroup/cpuset.c          | 11 +++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d629094fac6e..875d12598bd2 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -77,6 +77,7 @@ extern void cpuset_lock(void);
>  extern void cpuset_unlock(void);
>  extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *m=
ask);
>  extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> +extern bool cpuset_cpu_is_isolated(int cpu);
>  extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>  #define cpuset_current_mems_allowed (current->mems_allowed)
>  void cpuset_init_current_mems_allowed(void);
> @@ -207,6 +208,11 @@ static inline bool cpuset_cpus_allowed_fallback(stru=
ct task_struct *p)
>  	return false;
>  }
> =20
> +static inline bool cpuset_cpu_is_isolated(int cpu)
> +{
> +	return false;
> +}
> +
>  static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>  {
>  	return node_possible_map;
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolat=
ion.h
> index fe1a46f30d24..2b461129d1fa 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -2,6 +2,7 @@
>  #define _LINUX_SCHED_ISOLATION_H
> =20
>  #include <linux/cpumask.h>
> +#include <linux/cpuset.h>
>  #include <linux/init.h>
>  #include <linux/tick.h>
> =20
> @@ -67,7 +68,8 @@ static inline bool housekeeping_cpu(int cpu, enum hk_ty=
pe type)
>  static inline bool cpu_is_isolated(int cpu)
>  {
>  	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -		 !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> +	       cpuset_cpu_is_isolated(cpu);
>  }
> =20
>  #endif /* _LINUX_SCHED_ISOLATION_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 2a16df86c55c..dfbb16aca9f4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1518,6 +1518,17 @@ static void update_unbound_workqueue_cpumask(bool =
isolcpus_updated)
>  	WARN_ON_ONCE(ret < 0);
>  }
> =20
> +/**
> + * cpuset_cpu_is_isolated - Check if the given CPU is isolated
> + * @cpu: the CPU number to be checked
> + * Return: true if CPU is used in an isolated partition, false otherwise
> + */
> +bool cpuset_cpu_is_isolated(int cpu)
> +{
> +	return cpumask_test_cpu(cpu, isolated_cpus);
> +}
> +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
> +
>  /*
>   * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
>   * @cs: cpuset


No regressions when booting the kernel with this patch applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--7yiVXI7aBtIVC8K1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXBTCQAKCRD2uYlJVVFO
o0SOAPsGLs57YKlqeW0mamVOu9pFNmDonfvm0YtiCd+JhtIgiAD9HULH9VkRcoiO
FrFVJ5r7BQXi1aof2ssYAYE2qG3UWgc=
=+L7D
-----END PGP SIGNATURE-----

--7yiVXI7aBtIVC8K1--

