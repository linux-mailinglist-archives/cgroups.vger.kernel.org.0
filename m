Return-Path: <cgroups+bounces-7254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6656CA750D0
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 20:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F32D188E810
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44AA1E25E8;
	Fri, 28 Mar 2025 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Abk/1qNK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074E35972
	for <cgroups@vger.kernel.org>; Fri, 28 Mar 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190366; cv=none; b=fK0JLeyCF/JKHcWzwMHYKWEiSrX715pkiGL9Dcau5Eu+Su6HL5BlXo0VNaUJvgie2aOYhVW4gOht2OrR+2YTP/jLYFCSuGU7z891Z4ItniicxJXskE1pQm2DVXrRS4CTTtFRbPVBWh2M/Z9lFbIZqu4PlMPfWvZZKdZ+i2DSSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190366; c=relaxed/simple;
	bh=P3RoBtnRTWh0+Qe3N0FkyP1eVcCc9ZdIc/pM9bs+Z/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6bdyd14pdDY2hKy3d0p8YpNmSNjxhSZG7PdnjDzkeLvYfNCOgTCVcpM8rodyjYLDoHu5XBN8R1cvQg2B6DphbxUVpAplPwjm3kg+d+3fcVrvUj37XywYM17eCQcEaDXjApOvK64SMO1Vp0W9e5In/hajUU5ycGwdF35SN7cpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Abk/1qNK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOrICwGOkzKQ/+jrTMKKxHEEgn8NmGcpycUWQdIHE6U=;
	b=Abk/1qNKKK6tlMxsuD17mtxrO2LSQFyv080wQi8tksY73SclMvWtoBUs0krvFJbsDgtTYa
	XYfeghZtOdI1ofeSaiPTRoEcUclfrhMfHrAcFjY6vBOqkWDV0UD0h9GJK8QS25KqvwjUgZ
	Y+tlJWFiV3Vt0PrLiaIGewSCJZbGfec=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-5aIGiNCEPTCUQF7mXabGxg-1; Fri, 28 Mar 2025 15:32:41 -0400
X-MC-Unique: 5aIGiNCEPTCUQF7mXabGxg-1
X-Mimecast-MFC-AGG-ID: 5aIGiNCEPTCUQF7mXabGxg_1743190361
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5f876bfe0so218081485a.3
        for <cgroups@vger.kernel.org>; Fri, 28 Mar 2025 12:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190360; x=1743795160;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOrICwGOkzKQ/+jrTMKKxHEEgn8NmGcpycUWQdIHE6U=;
        b=gcciNKjF6QgPD8/TvFG7rl9Ppm0zGmfV7WRcVHqYoMc5IF86QO8k3NfimCnPr6r5Bc
         iGsjSCtaC0O3MSqxcY3DRPNnvFrmFSHuENE2J7mOwOiepgoGAb+9ZXex2/KN+9p88pOK
         LbzXApAL18NQv77RAMstwNGceCJ5LBwaYYMBzBFMVfqkEK1XQfEF8zffOn2eicbeL2n+
         /E1+HH+9uF6Rn+ih3GYSTrdWMFT6iTmBF0O9NTTsq2ua+aWpq2hRbLrAY0jx5V53JuuV
         fWzarpLyxnKQbSjEzz3geO/TdvUCAlligJrwomTky2qal781KI6L5AZf9utFJgZQ5RXe
         YPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOn6zRSOsqNFqBJ2oEv/nI+g7Ir/9GYGvPl+vOHzfwziV5TgvDEQa3KJRdpeHrfH/1jWjlV13I@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGNbIvDdvyqa7bQ4cnA8q5nUKxUSdR2Zo06ucoNnRSj1LtbTT
	HmdogJw5nFUzmBDDa44GW7oR4y+y/vKhWsv/n4u3roVKZSYm0weHWctpKI0XSgPKMkn+xe4QLDx
	G1njxBVzRGoUnJDVKeBNFJp3sD/ipLjQBJGNyXfHLZ2kj9RKU3krOrvk=
X-Gm-Gg: ASbGncvsdBBebbN70sy6+ua+1sKgJqkZ22xD24PzAYOBMKL5ye5/0675qNLOpEp+4Uu
	9VG/0DMMGWuS7VSV/1A/UPG39bbmZZwOKB46dvD4GA/AIE58viMth5Y31UcsLG27rp0mfO/Xqjf
	pkNQJzPM2VM+8n1UitTCsFblnVK6AuJy46PA1/9ML/Tc/HllqjIXxhIhe/FaPc+9ttbMJT6iJnv
	PZLkLne68ZsF6pG2mf5tzRn/VEi73pGkWXKp0Fofg6lqEJQWsTk+NmNlNVnkF/982vLcmaUPM2a
	gkg2dh8FhNxO/qI=
X-Received: by 2002:a05:620a:28cc:b0:7c0:bb3f:e285 with SMTP id af79cd13be357-7c690733764mr41925885a.24.1743190360492;
        Fri, 28 Mar 2025 12:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmxAH9Bkj6EcEA5G5CNFC/EUweXAoFqmSdTdkpGvOkNntLjjGVyjFGykTnKnzw0NPHOYaRNQ==
X-Received: by 2002:a05:620a:28cc:b0:7c0:bb3f:e285 with SMTP id af79cd13be357-7c690733764mr41921485a.24.1743190359985;
        Fri, 28 Mar 2025 12:32:39 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f765f9e8sm156980985a.12.2025.03.28.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:32:39 -0700 (PDT)
Message-ID: <c04233d3c35e2bad5a864ab72d0f55b3919100f3.camel@redhat.com>
Subject: Re: [PATCH 2/5] KVM: selftests: access_tracking_perf_test: Add
 option to skip the sanity check
From: Maxim Levitsky <mlevitsk@redhat.com>
To: James Houghton <jthoughton@google.com>, Sean Christopherson
	 <seanjc@google.com>, kvm@vger.kernel.org
Cc: Axel Rasmussen <axelrasmussen@google.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, Yu Zhao
 <yuzhao@google.com>, cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2025 15:32:38 -0400
In-Reply-To: <20250327012350.1135621-3-jthoughton@google.com>
References: <20250327012350.1135621-1-jthoughton@google.com>
	 <20250327012350.1135621-3-jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-03-27 at 01:23 +0000, James Houghton wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Add an option to skip sanity check of number of still idle pages,
> and set it by default to skip, in case hypervisor or NUMA balancing
> is detected.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Co-developed-by: James Houghton <jthoughton@google.com>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  .../selftests/kvm/access_tracking_perf_test.c | 61 ++++++++++++++++---
>  .../testing/selftests/kvm/include/test_util.h |  1 +
>  tools/testing/selftests/kvm/lib/test_util.c   |  7 +++
>  3 files changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> index 447e619cf856e..0e594883ec13e 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -65,6 +65,16 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
>  /* Whether to overlap the regions of memory vCPUs access. */
>  static bool overlap_memory_access;
>  
> +/*
> + * If the test should only warn if there are too many idle pages (i.e., it is
> + * expected).
> + * -1: Not yet set.
> + *  0: We do not expect too many idle pages, so FAIL if too many idle pages.
> + *  1: Having too many idle pages is expected, so merely print a warning if
> + *     too many idle pages are found.
> + */
> +static int idle_pages_warn_only = -1;
> +
>  struct test_params {
>  	/* The backing source for the region of memory. */
>  	enum vm_mem_backing_src_type backing_src;
> @@ -177,18 +187,12 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
>  	 * arbitrary; high enough that we ensure most memory access went through
>  	 * access tracking but low enough as to not make the test too brittle
>  	 * over time and across architectures.
> -	 *
> -	 * When running the guest as a nested VM, "warn" instead of asserting
> -	 * as the TLB size is effectively unlimited and the KVM doesn't
> -	 * explicitly flush the TLB when aging SPTEs.  As a result, more pages
> -	 * are cached and the guest won't see the "idle" bit cleared.
>  	 */
>  	if (still_idle >= pages / 10) {
> -#ifdef __x86_64__
> -		TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
> +		TEST_ASSERT(idle_pages_warn_only,
>  			    "vCPU%d: Too many pages still idle (%lu out of %lu)",
>  			    vcpu_idx, still_idle, pages);
> -#endif
> +
>  		printf("WARNING: vCPU%d: Too many pages still idle (%lu out of %lu), "
>  		       "this will affect performance results.\n",
>  		       vcpu_idx, still_idle, pages);
> @@ -328,6 +332,31 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	memstress_destroy_vm(vm);
>  }
>  
> +static int access_tracking_unreliable(void)
> +{
> +#ifdef __x86_64__
> +	/*
> +	 * When running nested, the TLB size is effectively unlimited and the
> +	 * KVM doesn't explicitly flush the TLB when aging SPTEs.  As a result,
> +	 * more pages are cached and the guest won't see the "idle" bit cleared.
> +	 */
Tiny nitpick: nested on KVM, because on other hypervisors it might work differently,
but overall most of them probably suffer from the same problem,
so its probably better to say something like that:

'When running nested, the TLB size might be effectively unlimited, 
for example this is the case when running on top of KVM L0'


> +	if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		puts("Skipping idle page count sanity check, because the test is run nested");
> +		return 1;
> +	}
> +#endif
> +	/*
> +	 * When NUMA balancing is enabled, guest memory can be mapped
> +	 * PROT_NONE, and the Accessed bits won't be queriable.

Tiny nitpick: the accessed bit in this case are lost, because KVM no longer propagates
it from secondary to primary paging, and the secondary mapping might be lost due to zapping,
and the biggest offender of this is NUMA balancing.

> +	 */
> +	if (is_numa_balancing_enabled()) {
> +		puts("Skipping idle page count sanity check, because NUMA balancing is enabled");
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Very good idea of extracting this logic into a function and documenting it.

> +
>  static void help(char *name)
>  {
>  	puts("");
> @@ -342,6 +371,12 @@ static void help(char *name)
>  	printf(" -v: specify the number of vCPUs to run.\n");
>  	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
>  	       "     them into a separate region of memory for each vCPU.\n");
> +	printf(" -w: Control whether the test warns or fails if more than 10%\n"
> +	       "     of pages are still seen as idle/old after accessing guest\n"
> +	       "     memory.  >0 == warn only, 0 == fail, <0 == auto.  For auto\n"
> +	       "     mode, the test fails by default, but switches to warn only\n"
> +	       "     if NUMA balancing is enabled or the test detects it's running\n"
> +	       "     in a VM.\n");
>  	backing_src_help("-s");
>  	puts("");
>  	exit(0);
> @@ -359,7 +394,7 @@ int main(int argc, char *argv[])
>  
>  	guest_modes_append_default();
>  
> -	while ((opt = getopt(argc, argv, "hm:b:v:os:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hm:b:v:os:w:")) != -1) {
>  		switch (opt) {
>  		case 'm':
>  			guest_modes_cmdline(optarg);
> @@ -376,6 +411,11 @@ int main(int argc, char *argv[])
>  		case 's':
>  			params.backing_src = parse_backing_src_type(optarg);
>  			break;
> +		case 'w':
> +			idle_pages_warn_only =
> +				atoi_non_negative("Idle pages warning",
> +						  optarg);
> +			break;
>  		case 'h':
>  		default:
>  			help(argv[0]);
> @@ -388,6 +428,9 @@ int main(int argc, char *argv[])
>  		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
>  	close(page_idle_fd);
>  
> +	if (idle_pages_warn_only == -1)
> +		idle_pages_warn_only = access_tracking_unreliable();
> +
>  	for_each_guest_mode(run_test, &params);
>  
>  	return 0;
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 77d13d7920cb8..c6ef895fbd9ab 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -153,6 +153,7 @@ bool is_backing_src_hugetlb(uint32_t i);
>  void backing_src_help(const char *flag);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>  long get_run_delay(void);
> +bool is_numa_balancing_enabled(void);
>  
>  /*
>   * Whether or not the given source type is shared memory (as opposed to
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 3dc8538f5d696..03eb99af9b8de 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -176,6 +176,13 @@ size_t get_trans_hugepagesz(void)
>  	return get_sysfs_val("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size");
>  }
>  
> +bool is_numa_balancing_enabled(void)
> +{
> +	if (!test_sysfs_path("/proc/sys/kernel/numa_balancing"))
> +		return false;
> +	return get_sysfs_val("/proc/sys/kernel/numa_balancing") == 1;
> +}
> +
>  size_t get_def_hugetlb_pagesz(void)
>  {
>  	char buf[64];



Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


