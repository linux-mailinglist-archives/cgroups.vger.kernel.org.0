Return-Path: <cgroups+bounces-4379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C833958DD0
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 20:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DEF282D74
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162D1BD507;
	Tue, 20 Aug 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cogYgMp6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630E2F5E
	for <cgroups@vger.kernel.org>; Tue, 20 Aug 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177484; cv=none; b=n6TH8vZkY4VZCQsLO3NXA1pUKDzMZiftzioCTD7GViVLxmLcJDc6hAYDzMpmoT4ltOX1tXOlTm8p9cJgfUt1i1SG0oQ1ewMt8gihVA0x0h2DbWwz7DNGojrtYF0hO1iXoV1T7J+yYZdHszkv/kcVbeZZHjVr0ANngxwrd4gmWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177484; c=relaxed/simple;
	bh=XneMk5AB/Ld/0ua5fEq1d5ZamL6PKW09l/gnJDxRGI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ9cbxaszMub/wAfT9rfpOj2sX/tWKqEPl5aS1UoWKfgu1blLdB3EVEPOHXZ+LUHI3qrwGL9m+ZzHlIpx+8zgAZ6pzac+YaVHjB43snW2gfU4Dcnins/ssiuH5XCHjs3XrjyHP6PTTcCj4/C9LTx9DDNilPASzGc2N2vyUepWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cogYgMp6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724177481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31k+mAE770tGzqnLjWcSobz9pBP+AeP9eCIK52t8r5E=;
	b=cogYgMp6CLJv4OoznFWbRG6rgbDnBM2oIR8W6o7a5xejVv6r3S5IX8fHRBTAjvjMcUdWtM
	CCEzAixkkrqsqKs7eVR2FdoJgzbvwh8WEMH30rka0yjACTb0RdWJcyU4bR2AMJw/vnHfc5
	J7IbCmWc4l+QuEOF3IltlIR64iZHtig=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-M1tRIWW5MJKJtlo0oKE-zw-1; Tue,
 20 Aug 2024 14:11:19 -0400
X-MC-Unique: M1tRIWW5MJKJtlo0oKE-zw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F3781872552;
	Tue, 20 Aug 2024 18:10:25 +0000 (UTC)
Received: from [10.2.17.12] (unknown [10.2.17.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BB131955BE1;
	Tue, 20 Aug 2024 18:10:22 +0000 (UTC)
Message-ID: <ed6c0892-459a-4af0-96fe-a22b6252b49a@redhat.com>
Date: Tue, 20 Aug 2024 14:10:22 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 0/3] Some optimizations about cpuset
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820030126.236997-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240820030126.236997-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 8/19/24 23:01, Chen Ridong wrote:
> The first patch changes from v1:
> 	Rename PERR_PMT to PERR_ACCESS, and update comments.
> 	Move 'xcpus_empty() check' up for local and remote partition.
>
> The follow patches have been reviewed by Longman.
> cgroup/cpuset: remove fetch_xcpus
> cgroup/cpuset: remove use_parent_ecpus of cpuset
>
> Chen Ridong (3):
>    cgroup/cpuset: Correct invalid remote parition prs
>    cgroup/cpuset: remove fetch_xcpus
>    cgroup/cpuset: remove use_parent_ecpus of cpuset
>
>   kernel/cgroup/cpuset.c | 71 ++++++++++++++----------------------------
>   1 file changed, 23 insertions(+), 48 deletions(-)
>
For the series,

Reviewed-by: Waiman Long <longman@redhat.com>


