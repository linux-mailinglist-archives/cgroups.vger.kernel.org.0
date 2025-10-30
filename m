Return-Path: <cgroups+bounces-11423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AEC1E8E2
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 07:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179F3188FDAB
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 06:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CC32AAC4;
	Thu, 30 Oct 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ykt5fwlE"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-38.ptr.blmpb.com (sg-1-38.ptr.blmpb.com [118.26.132.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECE38F9C
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805631; cv=none; b=uh7/lGqRmgDOUHWxgg++81ZCgPC3On1Ou/KkpD0pILaUn/UPPqROV7W6mCtBcZLjjt7nF1cFexunoUZP0qP4Q0nZMtjI+IaJrf/plhBpc/qxbxZ20Kp+e37yEFjgPFtQdp+eIZTRPCZ3GfohiwIx8LObsahGYOGCmCEOjX+cc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805631; c=relaxed/simple;
	bh=brnb8j6JQDLdqPeBwL0ti9KQcSTOELrs/QYpA4CltFg=;
	h=From:Message-Id:Mime-Version:Subject:References:To:Cc:Date:
	 Content-Type:In-Reply-To; b=kjNy+8yBwfwSePzw6DpBxr2CThvJ5KVitGN16xMHqyW0ZiXdJle8ehtpNP0OAD302RBHe7nVBCLsls9g5Yo6wRcQ9diL476YlZsJW0bnfL0uXDNqqJAkMlQUNKUhxHcTyGOyBRO4lWVMmL5diBeU6U6uDZnb5ezTm/u8MmA0gAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ykt5fwlE; arc=none smtp.client-ip=118.26.132.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761805613;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=brnb8j6JQDLdqPeBwL0ti9KQcSTOELrs/QYpA4CltFg=;
 b=ykt5fwlEXQer2mp0quHfsZiWZB5QIvaPFVgeYwg48i0kBCdpWZ4ukgSW64B/TUpbyAUvlR
 2539SPDlYUhQnaBvQo5/EeMioCArdrJrwldFaeOK4pYXxn78XR9Ae66yKPaHgMFh7jOsvl
 noQ5ASghEqZk2bXLzzT9NeabBVDugrHIgyMMIKdY1arKAPWd7ZEMTUsYQNHIJI5kQwPEHT
 As5FqRFFVoP8amVvQ6098vdFdlxmd+t0k0WVowWDYQfq6q/D0J82pdcgdn2rQ7Fb5ZhEOD
 tN8gFF76GdIv2KBcHGZj+OyhwO2ha70dfCR3q/4ozmCJFl3fAYcOGQjPvDJS5w==
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <6a9dc1b3-7953-449d-8afe-20febe421631@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26903052b+058d57+vger.kernel.org+yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Thu, 30 Oct 2025 14:26:50 +0800
Reply-To: yukuai@fnnas.com
Subject: Re: [REPORT] Possible circular locking dependency on 6.18-rc2 in blkg_conf_open_bdev_frozen+0x80/0xa0
Content-Transfer-Encoding: quoted-printable
References: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk> <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com> <5c29fa84-3a2c-44be-9842-f0230e7b46dd@acm.org> <544b60be-376c-4891-95a4-361b4a207b8a@linux.ibm.com> <aQHPgJNUW8aPPXTO@fedora> <ed1d37dc-e24d-4514-ba70-21ff1dc61381@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Ming Lei" <ming.lei@redhat.com>
Cc: "Bart Van Assche" <bvanassche@acm.org>, "David Wei" <dw@davidwei.uk>, 
	<linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>, <hch@lst.de>, 
	<hare@suse.de>, <dlemoal@kernel.org>, <axboe@kernel.dk>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <gjoyce@ibm.com>, <lkp@intel.com>, 
	<oliver.sang@intel.com>, <yukuai@fnnas.com>
Date: Thu, 30 Oct 2025 14:26:48 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <ed1d37dc-e24d-4514-ba70-21ff1dc61381@linux.ibm.com>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2025/10/30 13:48, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 10/29/25 1:55 PM, Ming Lei wrote:
>> On Tue, Oct 28, 2025 at 06:36:20PM +0530, Nilay Shroff wrote:
>>>
>>> On 10/28/25 2:00 AM, Bart Van Assche wrote:
>>>> On 10/23/25 9:54 PM, Nilay Shroff wrote:
>>>>> IMO, we need to make lockdep learn about this differences by assignin=
g separate
>>>>> lockdep key/class for each queue's q->debugfs_mutex to avoid this fal=
se positive.
>>>>> As this is another report with the same false-positive lockdep splat,=
 I think we
>>>>> should address this.
>>>>>
>>>>> Any other thoughts or suggestions from others on the list?
>>>> Please take a look at lockdep_register_key() and
>>>> lockdep_unregister_key(). I introduced these functions six years ago t=
o
>>>> suppress false positive lockdep complaints like this one.
>>>>
>>> Thanks Bart! I'll send out patch with the above proposed fix.
>> IMO, that may not be a smart approach, here the following dependency sho=
uld
>> be cut:
>> #4 (&q->q_usage_counter(io)#2){++++}-{0:0}:
>>
>> ...
>>
>> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
>> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
>>
>> Why is there the dependency between `#1 (&q->debugfs_mutex)` and `#0 (&q=
->rq_qos_mutex)`?
>>
> Okay this also makes sense: if we could remove the ->rq_qos_mutex depeden=
cy on
> ->debug_fs_mutex. However I also think lockdep may, even after cutting de=
pedency,
> still generate spurious splat (due to it's not able to distinguish betwee=
n
> distinct ->debugfs_mutex instances). We may check that letter if that rea=
lly
> happens.

This way we have to make sure debugfs_mutex is not held while queue is free=
zed, and
is also not nested under other locks that can be held while queue is freeze=
d. I think
it will be enough this way.

>> I remember that Yu Kuai is working on remove it:
>>
>> https://lore.kernel.org/linux-block/20251014022149.947800-1-yukuai3@huaw=
ei.com/

Yeah, I didn't continue work for new version because the problem I met is f=
ixed
Separately, this report might be another motivation.

> Let me add Yu Kuai in the Cc. BTW, of late I saw my emails to Yu are boun=
cing.
> But I found another email of Yu from lore, so I am adding it here - hope,=
 this

Thanks, I just left the previous employer and the old huawei or huaweicloun=
d email
can't be used anymore.

Thanks
Kuai

> is the correct email.
>
> Thanks,
> --Nilay
>

