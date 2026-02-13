Return-Path: <cgroups+bounces-13923-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDW3NAJtjmnuCAEAu9opvQ
	(envelope-from <cgroups+bounces-13923-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 01:14:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD38131F1F
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 01:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4F003018C29
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10D481B1;
	Fri, 13 Feb 2026 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjI057fn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342646B5
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941693; cv=none; b=ShiQBeElAjE2Cu4++MfpCRvbvrbwYSL2oYCR3bkQ/voFgaw/aDN+LWkqeLc1d53AwqK5JwN5xmbphO532Ijh4lXQ48WygcpXdvgfmG5vMMVuwhSBqJ2Yl6exqQ9Vsi4FJel4UXOi5g4NGNCjLh0WABF5T6rMOHt34I+sbhNfWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941693; c=relaxed/simple;
	bh=m2a6CuMCos/13elBxE7xrPOeupdB2O8QuOfKeNHD2Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nnf0EWfUy0hghEV+kV0O/otbYdkykYxPT/xs6jNVs196Ei3Kbl0jtmnRXyj5THtheJvZFzlKfPi4FKabARi7tLOP+nK+DUzSOTwyBy5BxYjxuTpaC4jO6BLy+YUC8S9HkS1FnhGerPLdOYekV8+m3rNXUFAHBHQpwFDFA7zd+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjI057fn; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12732e6a123so1298967c88.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770941691; x=1771546491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZOOjMHRTBJzKVIedfGL7gf236fJildms0DgDpjegcI=;
        b=ZjI057fn6h9yR2vnjUPjY/WBMFRNYjcB0lvj0WYarA4n5O8S0CUIPG3pMALzhbnmYh
         Sqzut951tUjbWUZk9dc02lmbBJx0XNiwLMiMoAZB51aCOnSN+1XmmZlEXCbvBZs8POZJ
         EYtlvQvTOuy5A8kFDIf5L68JoRhlejB/UL4hj7s7BLIvvIddePoDe68yomwbwuq5Z+ji
         Mqc9q7U7VWFYjELWCOv4RBPlWtUOuSkvds2xHY1mSu3JyFv6yaI6kQgxTkG2AqoWSfUZ
         MPp34XsQrBIy1v49tNXMl4AnnRBlT0cJKE5zy0AFTQIWfIfdmcHVO9qfHrPrScZ9svLv
         gDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770941691; x=1771546491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZOOjMHRTBJzKVIedfGL7gf236fJildms0DgDpjegcI=;
        b=eRiH811zWS4LRtONHRNwVBAZRkMUaPiIsk0FUrvoXbq3Nc0J53TqGM5Z9tjSwkEdQu
         ja9VUNnzuumyg8Y6KaaZ+HHv9V+CGr6CwcUeF3Hn1piWNaV1g3v0cFq9wOGJE0GnD2UC
         /k//Ggiu10R7kjlGmfOUtM/85N7Dh2rbf6f4QvpysQdqJNI0JnoodUEsVTPEZYCeFb6V
         TC4A3iZP+J+EfKYBd3OW3gxdD6iyira37MOnfpav0J+ZFi7UhSAWveKGx7haSamRxUXd
         cRiNQn9L8c+p3JxyvsO8eQGDrIdozseUi5YFHCaeHVKINwqM4zs+0H2cHLpWznP91OyW
         sOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1L5nldcADUBBHf22iuT61CFQ/2qO5NE+Z5O6Q/g0iY2oRqy9RW933ledLuqOVN6uGaiMLMkx@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwLWYPjcoC2cvQCuBuDu+DE6euUNWIvgH+rYqzI3Bxe4KdkIL
	IruNvlyXxz00QNzw3N5HgbMsYYvOQ3ucfs7xcVYHIPjCo4lcsyeTbw6x
X-Gm-Gg: AZuq6aLc55Zfcs01xjZcgTkRBRXsxhgBVh7+DFvWx06549M4jlzt31HAv7hYnjPFN5S
	MOfAHIrYGOca15/5nxkRcjSpo0avS/YbaqxdpGQDonfaugdHfZtiFHF0GZUo9CilWzzP1a0igW/
	KHcKy3wDnkeRLzyznxDXCxoj+AWJBMqZJl8ZW5fXGHkoKDyrk37rS6sdg8YpXxu6/OdYXgujjQp
	AtYEwa9o1KhfRAUpf1Nx8C0n9d2NN+fNVGmjZrLiXO4k4QCO6cDW04HtNnBvgLyNkNEMyEnMDQ0
	M9Chjp0v62qgO67OSjEky82YFp+xm3M6dHDFPJMYtu5tKHthiLHN8OrO8MOjQs3XTYU82Zo9+Eu
	Uu0EM6LTWX5UEsrc+qjaxm8DafFNF4QU43mifqF9YoLO2TuCSRe4AO6rpdP+URxotKFkjiVW0zu
	OaPynnWfQhgwPD7/FvckUSDkNJsb7oK4lF
X-Received: by 2002:a05:7022:690:b0:11b:7824:5c97 with SMTP id a92af1059eb24-12739846637mr323128c88.40.1770941690599;
        Thu, 12 Feb 2026 16:14:50 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a636095sm6909624c88.0.2026.02.12.16.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 16:14:50 -0800 (PST)
Message-ID: <e49fc187-0ef8-4557-abac-0082653fa645@gmail.com>
Date: Thu, 12 Feb 2026 16:14:48 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Check
 bpf_mem_cgroup_page_state return value
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Hui Zhu <zhuhui@kylinos.cn>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1770883926.git.zhuhui@kylinos.cn>
 <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13923-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.dev,cmpxchg.org,kernel.org,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AD38131F1F
X-Rspamd-Action: no action

On 2/12/26 12:23 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When back-porting test_progs to different kernel versions, I encountered
> an issue where the test_cgroup_iter_memcg test would falsely pass even
> when bpf_mem_cgroup_page_state() failed.
> 
> The problem occurs when test_progs compiled on one kernel version is
> executed on another kernel with different enum values for memory
> statistics (e.g., NR_ANON_MAPPED, NR_FILE_PAGES). [...]

This patch looks good but I think to fully solve this cross-kernel issue
we should use co-re in the bpf program. In your second revision, can you
add an additional patch to make use of bpf_core_enum_value()? This way
instead of relying on enum values in vmlinux.h at compile-time, we use
the btf info at load-time instead to get the proper value for the given
kernel.

