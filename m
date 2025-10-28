Return-Path: <cgroups+bounces-11282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A6C15DF5
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152B13AAF6A
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB4299927;
	Tue, 28 Oct 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UsFMAVyw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C90286887
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669111; cv=none; b=Y8yJMmWthmSXugKPXEzmZ19vp717KtpJ/rq4WVHE6dsZNOK5n00XeZpXzsoFOJSeYe1T71I6duNWUdW8zM6qL8w6B6WuEovqri9rbaEZh9SfCk25QnIYrGSaYjwOaj/IU3AFzmGIL/yrNSNj9fOt16MO3jQOuh2LzdiU+/2r5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669111; c=relaxed/simple;
	bh=0PucAMAox93xgjGrD5pR5CZazcj6sVnwd0fqWCdhArI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pw1safeRG4JcaQEvYmYbGM6uXdUn+Oz83mB5WUCmykHgZIeoxpzrX2h9yXeSo9a8YoirN7ZrAcIUnkGhA2yo7EyEnglGWaza3d2fx9n2clwsSBEv6J8W4Mz2Tb1bH4Of47FrrgNqlmbOY+Xq+B/e9/Sgp3kjDc6nlYmZDPXt0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UsFMAVyw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761669105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWSSRHmArf/3utDL/ehBcqRMhr+v6BRpRpOeVW9o8r8=;
	b=UsFMAVywaT8IpkoioAmt6vXomW1hLiGke5lnfdOFm6CT75B6FrTgPwndxR0Ld4UWB+GB6Z
	kNutJOjE/CXohXqu1fHCO5Wo3THXTOtts+MdPLoZN5i9dq8L67okdhsPKyc4EOyrIZ69wY
	ts6Gbva7I2Aaj5nD5s2hWpcBahe3SXQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 17/23] bpf: selftests: introduce read_cgroup_file()
 helper
In-Reply-To: <58dd6b759499f212f626e6d7658dd558b3e6a334e0780898002cb2cb84dbcb85@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:24 +0000 (UTC)")
References: <20251027232206.473085-7-roman.gushchin@linux.dev>
	<58dd6b759499f212f626e6d7658dd558b3e6a334e0780898002cb2cb84dbcb85@mail.kernel.org>
Date: Tue, 28 Oct 2025 09:31:38 -0700
Message-ID: <87ms5b3s45.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

> ```
> commit 712137918bba1b0a9c7c670bab9200b0f0d6a7e8
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> bpf: selftests: introduce read_cgroup_file() helper
>
> This patch adds a new helper function read_cgroup_file() to read from
> cgroup control files in BPF selftests. The function opens a file,
> reads into a buffer, and returns the result.
>
>> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
>> index 20cede4db..8fb02fe4c 100644
>> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
>> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
>> @@ -126,6 +126,45 @@ int enable_controllers(const char *relative_path, const char *controllers)
>>  	return __enable_controllers(cgroup_path, controllers);
>>  }
>>
>> +static size_t __read_cgroup_file(const char *cgroup_path, const char *file,
>> +				 char *buf, size_t size)
>> +{
>> +	char file_path[PATH_MAX + 1];
>> +	size_t ret;
>> +	int fd;
>> +
>> +	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
>> +	fd = open(file_path, O_RDONLY);
>> +	if (fd < 0) {
>> +		log_err("Opening %s", file_path);
>> +		return -1;
>
> Can __read_cgroup_file() return -1 when its return type is size_t?
>
> The function signature declares size_t (unsigned), but returns -1 here.
> When -1 is implicitly converted to size_t, it becomes SIZE_MAX
> (18446744073709551615 on 64-bit systems). Callers checking for errors
> with "if (ret < 0)" will fail because size_t is unsigned, and callers
> checking "if (ret == -1)" will also fail after the cast.
>
>> +	}
>> +
>> +	ret = read(fd, buf, size);
>> +	close(fd);
>> +	return ret;
>
> Does this handle read() errors correctly?
>
> The read() syscall returns ssize_t which can be negative on error.
> Assigning this to size_t (line 143) converts negative error codes into
> large positive numbers. For example, read() returning -1 becomes SIZE_MAX
> when stored in ret.
>
> Should the return type be ssize_t instead of size_t to properly propagate
> both success (byte count) and error (negative values) to callers?

Correct, fixed to ssize_t. Thanks!

