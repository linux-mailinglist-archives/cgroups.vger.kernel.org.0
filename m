Return-Path: <cgroups+bounces-2908-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1098C5F8E
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 06:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D05D1F22528
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 04:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5C381D4;
	Wed, 15 May 2024 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzkGSJkx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7238FA5
	for <cgroups@vger.kernel.org>; Wed, 15 May 2024 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745619; cv=none; b=OFVoTTUsT1BMjVq0i0uZi7m8Op9a/iR6RM4u8/9aU1ePxSljVPeMm+nnxcODWSN4OqBOoFvM19J274jdDQf8mbGX4fDa9ynKwNS7IUyzoNweiBdyQV5GQzUCKyn+KxxdrjLGe1mZVtwUqn+oU8sMixfBWoYhn+Ec1nQ+S56148Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745619; c=relaxed/simple;
	bh=FS8BxcGOh1QyUsPCb/Z1Pw2aO5KhRVPLl/8FppUGhgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMhRcrNo7EdWnSkI6wX+mJLbU6azqF8cWJlWbT/dZoaPsB2PSK08VvYl6aBCgEnh7jnmnSaoaFaYmhza+zvFnZwEz6RUF+zFQZTzL5b+dHGlMRiG8cQruYYCPT+UDXP4i3Mg37HbyHyHo2mcQK76M93b7ioDIzZhdaTIklCkGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzkGSJkx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715745616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfxw+vb/eMFY8ya0z6a2BGMJqEE78GiWToX1LII8WvU=;
	b=HzkGSJkxWR7JhCqdDsxfAWgD40miKOjTp4ogkvlfAeu8jARjkzO+eYQutDi3B3QG7tShHX
	5qFAyP5Hu6MaNN/LnAbyGye1ZTqjwCZ8drdM/iRmKpuwP8I1wHVG+dm0tVg4sS0dhwPQte
	PelFtjqzBFBJOnTlRGUVlHYPIi5erqo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-9owWtM1FNJSMY9rCzR2n2w-1; Tue,
 14 May 2024 23:59:56 -0400
X-MC-Unique: 9owWtM1FNJSMY9rCzR2n2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 298621C4C380;
	Wed, 15 May 2024 03:59:56 +0000 (UTC)
Received: from [10.22.8.47] (unknown [10.22.8.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D22FF3C27;
	Wed, 15 May 2024 03:59:55 +0000 (UTC)
Message-ID: <3ed32279-904a-411d-91a4-a62f4ca2dde2@redhat.com>
Date: Tue, 14 May 2024 23:59:55 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup io.stat propagation regression
To: Dan Schatzberg <schatzberg.dan@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 5/14/24 15:25, Dan Schatzberg wrote:
> Hi Waiman,
>
> I've noticed that on recent kernels io.stat metrics don't propagate
> all the way up the hierarchy. Specifically, io.stat metrics of some
> leaf cgroup will be propagated to the parent, but not its grandparent.
>
> For a simple repro, run the following:
>
> systemd-run --slice test-test dd if=/dev/urandom of=/tmp/test bs=4096 count=1
>
> Then:
>
> cat /sys/fs/cgroup/test.slice/test-test.slice/io.stat
>
> Shows the parent cgroup stats and I see wbytes=4096 but the grandparent cgroup:
>
> cat /sys/fs/cgroup/test.slice/io.stat
>
> shows no writes.
>
> I believe this was caused by the change in "blk-cgroup: Optimize
> blkcg_rstat_flush()". When blkcg_rstat_flush is called on the parent
> cgroup, it exits early because the lockless list is empty since the
> parent cgroup never issued writes itself (e.g. in
> blk_cgroup_bio_start). However, in doing so it never propagated stats
> to its parent.
>
> Can you confirm if my understanding of the logic here is correct and
> advise on a fix?

Yes, I believe your analysis is correct. Thanks for spotting this iostat 
propagation problem.

I am working on a fix to address this problem and will post a patch once 
I have finished my testing.

Thanks,
Longman


