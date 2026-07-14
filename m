Return-Path: <cgroups+bounces-17755-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +PSdJ4ymVWqWrQAAu9opvQ
	(envelope-from <cgroups+bounces-17755-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 05:01:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B99750887
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 05:01:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=SWuFUOhZ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17755-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17755-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70985301020F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414663939B0;
	Tue, 14 Jul 2026 03:00:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221F38A70A
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 03:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998048; cv=none; b=Mj4U/X2g2z1Q5b/bt/lkw5V3v0kIUwZbiidKpy6J0fx90xklchAnCJLf7g4lsc95GaZUQwRM+PEYY5K9k+ianT8BcUb/o8QviTCRhrLRsYwC98+uYzkSOdkkUXU5rqkooIBs3bXN8BVlEngU09MtuPB2HwFL+55pO+SZ/T2rUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998048; c=relaxed/simple;
	bh=22yk4dtBcV8Fk6ccHwis66VNqhMb7AAYAoTRbQtrkes=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GTr0mxwoxjK2z02g7cd7K/2f9CRSC7QSqqcHo3b1gv77vzrhY2AodmgMWTNBM4Ca6UTb58FpIkl8Kzbc+jZHkAKC3Rsj4kDPjOjyXQ4NJuvBgosSbWpGcUfnQ0JxO+4EZMgQ5rhjxtHfc9VtkscG3fbzvK8xBtpWNc1dhTnrt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SWuFUOhZ; arc=none smtp.client-ip=91.218.175.184
Message-ID: <e60ca749-ddeb-46f1-baf8-01db8a2df1b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783998028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4XC4Tt2Er5SVTqQ4QRZas9ffsbGhNq4gF6E+smuGPU=;
	b=SWuFUOhZ2qAjtWWzx8WPyPnFFagUYtKh3FmiI2Eo4/FG8MdhayLP+WXKB1zAuW1Q6eGqQK
	0iVHmFzsQNm0SAPBgDarv8HbpIHA8q5h3T0c9SRpswbEuNvcmu4SNtHBhLsZgFNhXAXSAo
	rWUWU/ho9C6k7xPsFvGg7knT0IW+gWs=
Date: Tue, 14 Jul 2026 11:00:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org,
 mkoutny@suse.com, shuah@kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/cgroup: fix missing TAP output in
 test_hugetlb_memcg
To: Song Hu <husong@kylinos.cn>, linux-mm@kvack.org
References: <20260714021511.1063700-1-husong@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260714021511.1063700-1-husong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17755-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:husong@kylinos.cn,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93B99750887



在 2026/7/14 10:15, Song Hu 写道:
> main() in test_hugetlb_memcg never calls ksft_print_header(),
> ksft_set_plan(), or ksft_finished(), so its output has no TAP plan and is
> not valid TAP, unlike the sibling test_memcontrol and test_kmem tests.
> Add the header/plan/finished calls following the same pattern.
> 
> Signed-off-by: Song Hu <husong@kylinos.cn>
> ---
>  tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> index b627d84358b1..8c5aced813b6 100644
> --- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> +++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> @@ -199,7 +199,10 @@ static int test_hugetlb_memcg(char *root)
>  int main(int argc, char **argv)
>  {
>  	char root[PATH_MAX];
> -	int ret = EXIT_SUCCESS, has_memory_hugetlb_acc;
> +	int has_memory_hugetlb_acc;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
>  
>  	has_memory_hugetlb_acc = proc_mount_contains("memory_hugetlb_accounting");
>  	if (has_memory_hugetlb_acc < 0)
> @@ -211,7 +214,7 @@ int main(int argc, char **argv)
>  	if (get_hugepage_size() != 2048) {
>  		ksft_print_msg("test_hugetlb_memcg requires 2MB hugepages\n");
>  		ksft_test_result_skip("test_hugetlb_memcg\n");
> -		return ret;
> +		ksft_finished();
>  	}
>  
>  	if (cg_find_unified_root(root, sizeof(root), NULL))
> @@ -233,10 +236,9 @@ int main(int argc, char **argv)
>  		ksft_test_result_skip("test_hugetlb_memcg\n");
>  		break;
>  	default:
> -		ret = EXIT_FAILURE;
>  		ksft_test_result_fail("test_hugetlb_memcg\n");
>  		break;
>  	}
>  
> -	return ret;
> +	ksft_finished();
>  }

This one looks good to me — it mirrors the test_memcontrol/test_kmem
pattern and the exit-code semantics are preserved.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

