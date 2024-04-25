Return-Path: <cgroups+bounces-2704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08F8B2194
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A21F1F22CE3
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF312BF38;
	Thu, 25 Apr 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCiAd/98"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5D85C52
	for <cgroups@vger.kernel.org>; Thu, 25 Apr 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047894; cv=none; b=JzIN183y2+iTPDNi+vxO4O3TUtgO1cMb6ldMKfZHK9Sh/6PtU2niSw04VsO4mxHI7Af2g5q0FDWeWUulEwkG5zGgx8rKIVOAHoxf09B2UUaiwyoFNnPxRyRjDEvMGzGGNQPYJRtuHNTZC7mMlfetyuZ4o9rUOf+a6xsBoFHG8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047894; c=relaxed/simple;
	bh=M71qeK8Sdn8NVW2kZBFrMrpoDYzrjWTiYmyUYOxRzpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sc/aHjkyNgapU3T+qOpmKlezxjKfjrPforiiRcBHakhH48VtTPGtdpLickpUGe3RtEbdGN63Vbv8zCSwzep8o9F4lLqDNC/aOFDIH603ixEVR5dy4xQqR6wBScMCegua5Byb0Y6t4r1yoJ4hHGmJzc/EBq7pvCTig+brf/X5wPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCiAd/98; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714047891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRbwdG+1XunRLInxSf/AH761bg3jaFbuEZ5fAcJb3TY=;
	b=WCiAd/98ZAJ/+6e+9t4eas6Bxz6uSWE/5py6vdJDZ7mIhyOmtWVUSGRhUHXeopzkIl3xrZ
	jnLZ+BFiKz3vPfhFuIQjlrxztz5kv/EJlsAMLtf08KpKK3lzYPx6KjjPW4wqt2rXNStUny
	sKt+cUEL2g9/zwQRd8kNv+1V4Oxhs9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-fbcaXE1cMpCWsRlt9eVr4g-1; Thu, 25 Apr 2024 08:24:48 -0400
X-MC-Unique: fbcaXE1cMpCWsRlt9eVr4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3252800CA2;
	Thu, 25 Apr 2024 12:24:47 +0000 (UTC)
Received: from [10.22.17.9] (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 81A7040F01A;
	Thu, 25 Apr 2024 12:24:47 +0000 (UTC)
Message-ID: <a834a59d-9f31-4374-923f-ddd89780b62a@redhat.com>
Date: Thu, 25 Apr 2024 08:24:46 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Remove outdated comment in
 sched_partition_write()
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240425093016.1068567-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240425093016.1068567-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 4/25/24 05:30, Xiu Jianfeng wrote:
> The comment here is outdated and can cause confusion, from the code
> perspective, there’s also no need for new comment, so just remove it.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f5443c039619..a10e4bd0c0c1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3774,9 +3774,6 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>   
>   	buf = strstrip(buf);
>   
> -	/*
> -	 * Convert "root" to ENABLED, and convert "member" to DISABLED.
> -	 */
>   	if (!strcmp(buf, "root"))
>   		val = PRS_ROOT;
>   	else if (!strcmp(buf, "member"))

Yes, that comment is now no longer relevant.

Acked-by: Waiman Long <longman@redhat.com>


