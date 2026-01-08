Return-Path: <cgroups+bounces-12970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4ECD0262E
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B150300D80C
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F149365A11;
	Thu,  8 Jan 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I7EVdV8+"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-106.ptr.blmpb.com (sg-1-106.ptr.blmpb.com [118.26.132.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149333D4E5
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861861; cv=none; b=Pln9rBKR0dwIGT/hfr+JoyD5vRiuEaXFuaxWPYs0boEqxUmUgKNxtk5bXT3vtM//VbHEJBAps/EgmazvRmjx8k4N9Hy9ANEMj0MIa9Sbku2uh0v3R9Y1f1ZQW+xsz/YayntHS8xXfwW6bmmnijR78bIm3mAfoWXRKNlIwRwp5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861861; c=relaxed/simple;
	bh=8XAL+S3qR8EIc++riYq98GXTctvOfapL1gd1t4E9z/0=;
	h=In-Reply-To:To:Subject:Content-Type:Cc:From:Mime-Version:
	 References:Date:Message-Id; b=SLxpO/e49/BijVULLJm4nKZqwNkQYEsPJJm+MVg/6pENuYzBE01V1itwuoU65HYAgGSohsUX80tkaXIqz0lVpu2xf1EdaH/J5a9NFXDHmzTseKr9DEq+xGeV1eVp5sNcouFBuajDQWop6utI+zoqTlIYXE9QKlBdsVXZl/zq57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I7EVdV8+; arc=none smtp.client-ip=118.26.132.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767861839; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=N1FuXjS01s3YMgMgzoZhF0uCB3O/s+D9Jm9fJvlCcWo=;
 b=I7EVdV8+EOk9KvCmJ2bXtrKDnFFxQSlMQ3PDAEY+DGJZDgmBzdwHX0bFiCbNnRx8cpI9r5
 mP/6+1GR4WW6p801cbjP5ynNt6mULVvbNzlk8IelP8eVQhtW0/WXeISYz0OiAIAClZ+ouA
 4DVMrUmFIeGScfZm6Ygi4e5d4/+Az/ERBFY4+EV3OtSc0HdrhZEwgpxPqrpfvXd/f2GK1r
 /rHYz6iFmAGpTcmeeMMtAS7CWY9Y8QV5Nd3xQSyAiaVIeXhAhQAc4eWNApSBBaJMBuFq4T
 lSrGJDa5L7aJmJ35pXojg2S2tq3O8f/U4BkyzLulRHj3kETpAyfLbTg8Pz0rsw==
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
In-Reply-To: <20260107190534.GA441483@bhelgaas>
To: <helgaas@kernel.org>
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent isolated cpuset change
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2695f6e4d+a97eb7+vger.kernel.org+guojinhui.liam@bytedance.com>
Cc: <akpm@linux-foundation.org>, <axboe@kernel.dk>, <bhelgaas@google.com>, 
	<catalin.marinas@arm.com>, <cgroups@vger.kernel.org>, 
	<chenridong@huawei.com>, <dakr@kernel.org>, <davem@davemloft.net>, 
	<edumazet@google.com>, <frederic@kernel.org>, <gmonaco@redhat.com>, 
	<gregkh@linuxfoundation.org>, <guojinhui.liam@bytedance.com>, 
	<hannes@cmpxchg.org>, <horms@kernel.org>, <jiangshanlai@gmail.com>, 
	<kuba@kernel.org>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <linux-pci@vger.kernel.org>, <longman@redhat.com>, 
	<marco.crivellari@suse.com>, <mhocko@suse.com>, <mingo@redhat.com>, 
	<mkoutny@suse.com>, <muchun.song@linux.dev>, <netdev@vger.kernel.org>, 
	<pabeni@redhat.com>, <pauld@redhat.com>, <peterz@infradead.org>, 
	<rafael@kernel.org>, <roman.gushchin@linux.dev>, 
	<shakeel.butt@linux.dev>, <tglx@linutronix.de>, <tj@kernel.org>, 
	<vbabka@suse.cz>, <will@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107190534.GA441483@bhelgaas>
Date: Thu,  8 Jan 2026 16:43:26 +0800
Message-Id: <20260108084326.1952-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1

On Wed Jan 7, 2026 at 13:05:34 -0600, Bjorn Helgaas worte:
> [+cc Jinhui]
>=20
> On Thu, Jan 01, 2026 at 11:13:26PM +0100, Frederic Weisbecker wrote:
> > HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> > therefore be made modifiable at runtime. Synchronize against the cpumas=
k
> > update using RCU.
> >=20
> > The RCU locked section includes both the housekeeping CPU target
> > election for the PCI probe work and the work enqueue.
> >=20
> > This way the housekeeping update side will simply need to flush the
> > pending related works after updating the housekeeping mask in order to
> > make sure that no PCI work ever executes on an isolated CPU. This part
> > will be handled in a subsequent patch.
> >=20
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>=20
> Just FYI, Jinhui posted a series that touches this same code and might
> need some coordination:
>=20
>   https://lore.kernel.org/r/20260107175548.1792-1-guojinhui.liam@bytedanc=
e.com
>=20
> IIUC, Jinhui's series adds some more NUMA smarts in the driver core
> sync probing path and removes corresponding NUMA code from the PCI
> core probe path.

Hi Bjorn,

Thanks for pointing out the series.

I=E2=80=99ll resolve the conflicts and send a new patchset once this one is=
 merged.

Best Regards,
Jinhui

