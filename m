Return-Path: <cgroups+bounces-3416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86891AF29
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A179283E5A
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF319AA54;
	Thu, 27 Jun 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVYV2gYc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167262139D6
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513467; cv=none; b=sjk0XtHUNCZCjIqAWFMufT3ygH/+9IBUfkKG+el2D0VOlHtmEBEJMoV9++dbL9jxxyzpmr4Tthw+E2yqKL/AVtcrACMMoCtzKcmBLeYfzzWLfc6oj8H+LEaIZWpI+2N/oe+p49JVUpdhYgIFzy5agnZW0iXAUWJ/uzlMzmX93Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513467; c=relaxed/simple;
	bh=ZJskPZQSLQ5DwBvbcMuZBDg36CXApm4ZGK1eTz5bnzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1ISD1d3Uda4TkVHzyi03WkgB+q8bKcRU1KS+3wWljnIGF94nzHD8rH/v5WJNIk6SmYNghOqvgnvk7jRvmJOsnM2s4P7TkmKGm0+c8fyipuWk1ASujhk3xKY9bvdluSX45LhiwgtcoEmftfqKJ0YmaX48hWbcfMkcg/E31lD1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVYV2gYc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719513464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esgjbKav9b6da2mPBgVetL8kWuGq0K5eo3PdQsYu6Oo=;
	b=EVYV2gYcfYVwihE/YUX9nmvqS1UkC4gWdYqyZG7fLj7pORf0YpXAjgpDgKPWxSeLrMoX7j
	GzdfzE7Eqy6W1R3WwDYLkGtYfbCkiUsa9h1d5mwaPBORVGGyF/TPTAN6HDysFxIYnOmUIs
	wHY546d6ktqIzQkOs/WeDiCfqPJB1e4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-be8D8ntYOGG7V6u-qcKjuw-1; Thu,
 27 Jun 2024 14:37:41 -0400
X-MC-Unique: be8D8ntYOGG7V6u-qcKjuw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BC73195609E;
	Thu, 27 Jun 2024 18:37:38 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BD9F1955BD4;
	Thu, 27 Jun 2024 18:37:36 +0000 (UTC)
Message-ID: <c12f62fb-7cdc-476f-b6d2-deff2570d7df@redhat.com>
Date: Thu, 27 Jun 2024 14:37:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, adityakali@google.com, sergeh@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240626094101.472912-1-chenridong@huawei.com>
 <6mjie6enbm5ltei4fsanz64ofukbr4gvss7ywi5sjfjxjxing7@efuhtnqvfawd>
 <Zn2vjVNnIcUN8lXM@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zn2vjVNnIcUN8lXM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 6/27/24 14:29, Tejun Heo wrote:
> Hello,
>
> On Thu, Jun 27, 2024 at 11:46:10AM +0200, Michal Koutný wrote:
>> Your patch should work thanks to the rcu_read_lock and
>> cgroup_free_root/kfree_rcu and the `if (css->cgroup)` guard is
>> unnecessary.

I also notice that the if (css->cgroup) guard is not needed. I didn't 
reject it because it doesn't hurt.

Cheers,
Longman

>>
>> So the patch is a functional fix, the reasoning in commit message is
>> little off. Not sure if Tejun rebases his for-6.10-fixes (with a
>> possible v4), full fixup commit for this may not be worthy.
> This one's on the top. If Chen can send me a patch with updated description,
> I will replace the patch.
>
> Thanks.
>


