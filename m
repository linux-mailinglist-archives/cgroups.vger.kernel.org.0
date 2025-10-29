Return-Path: <cgroups+bounces-11321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C7C190D9
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8AFB355E54
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C4320A31;
	Wed, 29 Oct 2025 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSZ7/u08"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554431D742
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726366; cv=none; b=WGt/XjCIxmrK4yUTKQrTsw1XEH83HbjCVMgDeOqyKm+O1wUG6qmjZkjcc5EXh/Gf/tKnI1WYLsVMawWy1+lj5np3zMA6OVjtjTF4xTn+15S5jzpnbT6WI4oRsQy1xg9dOwmKioBcWci/LzcQvY+NxcyE1xGgtO8TG36QdDzIDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726366; c=relaxed/simple;
	bh=xgqj5pCdNpa3XGWQgvu4tLTxUw7yCDJ8VB0Ba9N5jEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlV3IJNR3PmrnEksDX1Es255ClVCrA+biH/BD/7AdDNg/jhKXGChldtoRkqGLb/YX2N4+i9lgKWf1t8Y6g4N0EaK3YTDn/0JPLVchDy0mSeas9w3uTH9EMKmBonSt3CfWSI8j6LU1+jmDF4ujfyVzA84xR/DXzUAbEnXTsIlZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSZ7/u08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761726363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FLgqPzpwGlfIs1RiLXNE1Fv1B7Pn8WCEkos9O7vhm/s=;
	b=CSZ7/u08qQzT61nWf25ARHD3/yU0sgSojfPYStyDB8ZuNXe7i8wN5kQJVfavbrSqo8OZqV
	nBo9YwrtASgqYWujj91TskdysHEqIqWmACoYKF0PXtdMP22UOyKrWmcNmegD4ee4tgk2RO
	Chb1RyxlC4R3nuFti0TXOEOER6+4vZY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-un4H5XgKPju8loE7Q5Sm_Q-1; Wed,
 29 Oct 2025 04:25:57 -0400
X-MC-Unique: un4H5XgKPju8loE7Q5Sm_Q-1
X-Mimecast-MFC-AGG-ID: un4H5XgKPju8loE7Q5Sm_Q_1761726351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97F051808997;
	Wed, 29 Oct 2025 08:25:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57CB81800586;
	Wed, 29 Oct 2025 08:25:41 +0000 (UTC)
Date: Wed, 29 Oct 2025 16:25:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Bart Van Assche <bvanassche@acm.org>, David Wei <dw@davidwei.uk>,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org, hch@lst.de,
	hare@suse.de, dlemoal@kernel.org, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, gjoyce@ibm.com, lkp@intel.com,
	oliver.sang@intel.com
Subject: Re: [REPORT] Possible circular locking dependency on 6.18-rc2 in
 blkg_conf_open_bdev_frozen+0x80/0xa0
Message-ID: <aQHPgJNUW8aPPXTO@fedora>
References: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
 <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com>
 <5c29fa84-3a2c-44be-9842-f0230e7b46dd@acm.org>
 <544b60be-376c-4891-95a4-361b4a207b8a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544b60be-376c-4891-95a4-361b4a207b8a@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Oct 28, 2025 at 06:36:20PM +0530, Nilay Shroff wrote:
> 
> 
> On 10/28/25 2:00 AM, Bart Van Assche wrote:
> > On 10/23/25 9:54 PM, Nilay Shroff wrote:
> >> IMO, we need to make lockdep learn about this differences by assigning separate
> >> lockdep key/class for each queue's q->debugfs_mutex to avoid this false positive.
> >> As this is another report with the same false-positive lockdep splat, I think we
> >> should address this.
> >>
> >> Any other thoughts or suggestions from others on the list?
> > 
> > Please take a look at lockdep_register_key() and
> > lockdep_unregister_key(). I introduced these functions six years ago to
> > suppress false positive lockdep complaints like this one.
> > 
> Thanks Bart! I'll send out patch with the above proposed fix.

IMO, that may not be a smart approach, here the following dependency should
be cut:

#4 (&q->q_usage_counter(io)#2){++++}-{0:0}:

...

#1 (&q->debugfs_mutex){+.+.}-{4:4}:
#0 (&q->rq_qos_mutex){+.+.}-{4:4}:

Why is there the dependency between `#1 (&q->debugfs_mutex)` and `#0 (&q->rq_qos_mutex)`?

I remember that Yu Kuai is working on remove it:

https://lore.kernel.org/linux-block/20251014022149.947800-1-yukuai3@huawei.com/


Thanks,
Ming


