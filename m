Return-Path: <cgroups+bounces-760-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CB800E39
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F62F1C20FED
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79C4A996;
	Fri,  1 Dec 2023 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gQ+7/zk5"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F97194;
	Fri,  1 Dec 2023 07:14:29 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 89C3D2C5;
	Fri,  1 Dec 2023 15:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 89C3D2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1701443668; bh=WgqQVcNyNmSbLfTjiMUoVBz8fOQdTqP7Vk/w7Mq97Tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gQ+7/zk53MU65Q9BhQu3PiDAnHWkABz5ecDkMlvhBbFkILB5tLGpdKe0F/2wFZfbY
	 eqVlMjd5Sq7jRfIJ7Z/n6kz645qpoGi/8nHpNY/iHu5Obdy09Rd8UmX0Q51OV4MaBa
	 j/B5A+w4ukQq4tY88nds+bRNqz+vIpmsMHSZruIGCEg/v1nTWG7c13Erbc9boSZqUi
	 lCSqF/zRv5lahYRGnYaEByQIeGIGAL8mQ4nQYm/a90f+rFKOpc76ISBEKeTztCuN14
	 XNXPUNTG9e8k0WZVcc366Pw3zvovx/XkmrqimTJ9x0YKsvPBY5Ax6oZUzabns6lrwU
	 HVEDgX8RUJwsg==
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Josh Don <joshdon@google.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>
Cc: Linux CGroups <cgroups@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] cgroup: Fix documentation for cpu.idle
In-Reply-To: <ZWlzwnO7PcOWQ2q_@archie.me>
References: <20231201005203.309873-1-joshdon@google.com>
 <ZWlzwnO7PcOWQ2q_@archie.me>
Date: Fri, 01 Dec 2023 08:14:27 -0700
Message-ID: <87fs0meyzw.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Thu, Nov 30, 2023 at 04:52:03PM -0800, Josh Don wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 3f85254f3cef..9debf02bcb39 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> +  cpu.idle
>> +	A read-write single value file which exists on non-root cgroups.
>> +	The default is 0.
>> +
>> +	This is the cgroup analog of the per-task SCHED_IDLE sched policy.
> "... cgroup analogy to ..."
>> +	Setting this value to a 1 will make the scheduling policy of the

Bagas, please stop this (again).  The original wording is better than
your suggested "improvement".

jon

