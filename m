Return-Path: <cgroups+bounces-2195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1E88F225
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 23:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FD12985B4
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF1153BEE;
	Wed, 27 Mar 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYewmMvm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9F2EB04
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580038; cv=none; b=ESGkQ7okOCRz6B29KNKRoBK43ccslg2pxaW2sSZewUixWD0cbBpxvTpmRTSW7HdVwuA89TYJyZ+IEQr2ZTR9L0/nxX1ABjxZXbMdj97K5qXspSof6jSTakJgnLv8xJN0NYjAHuSZNnpZkCkFJl8XlXk/Y+9xbk3oJFZOinlg2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580038; c=relaxed/simple;
	bh=ippSELgaRyUKakbXbpn0arphUywutW7eB+Upxu7AcEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hym6+qAubzuSlsC7A/yV23snmBES4Ezi4mem9m3n72vQo50FCIrdNF2FKAFjOTFWwKzzhD3dxSPliVwcMXzMHKkVF6YSLjnm0toi69iroz6s1Ed3Aan5NFO1Lo+DuML3hNsT1ezVxbK4FVxw5yDTQL71SdDYDPgMAAz6eHbCDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYewmMvm; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db3a09e96daso338798276.3
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 15:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711580035; x=1712184835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddFX6WA7Vse1WsWNG5JUtWurIddg/WeWShq3oKWotbI=;
        b=KYewmMvmb3rOnZ/lt9sqYPiXvG9/UqqkM/vdJbQa8BxC20jBCkB+OUkqorM8ZaT5Of
         toWq+d5aZEzQ5jqtYKUwFTQc0QwMcHYQPtVUNZDyK5QEVDP1tVxxUzS3YA2NY5PetQaI
         MI6yCs96ZH37+YdpfqYpU37ShSD8KjtTHi+AnMDOOLXvxXX+wM6pfjQG5zMY0hfP++Kx
         UwbwWq2egI0x9Y8ASJd4e93Z+7uIDkD6eNS4Oa+xGMWI6EjAqzucoawvo4LmlRCX+OGm
         t3Cwp5le2DSjx9rqxDBNPWBcLoDoR2CflrCLZ+5faD7I/m5MPXJ/38yzjxW9wVsXK9Jz
         fuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580035; x=1712184835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddFX6WA7Vse1WsWNG5JUtWurIddg/WeWShq3oKWotbI=;
        b=NfNVvVaJ2Y/zLdjwaLbk6RfUNUgG2VSBM8lEh71D60SIXKeECLv45/f6Lysxf8M/A5
         UKnuWJqt2Xb6L3ie5d8ryEWenZ8hmaM588MwwCIUfzF5DMqQljIFpATZFslrGURhmWtf
         gVAsHivQdInRikuZFgnqB/mYxD23WZNPPxmkxKgO3NihoqL8NEa5Hul69SqOc4DOI7Em
         70Njm06Gw19DBzFBK6pTSiVa1JwXGNpSgEIRLnIRLTJmnuBJETNcieEh0qfFWwG2BYeJ
         7dOXHto9Q2zk0WCj7KbAUCsfMWOAoKVBVgmg7+a0XCe5hViwyombZRndb8GqTKsjtiRQ
         MD1g==
X-Forwarded-Encrypted: i=1; AJvYcCUJjE42MHq5dqVRgbZwGSSrHptVRlNyZaSPetNiGbxy5dpthvGyO6wTi0/RxW8+43zLPrEObCM51K13R1ces0ZMErm+IxjaaQ==
X-Gm-Message-State: AOJu0YwK7Qo9lfHZp2VO/1NVXNS0lPAvsq7H6K65AZhfox+MJMwEfqAN
	Cviz64NRupUM91a/2rMyyiPuIVdUd4q951J6f8ohpa16lO33GoiKBYtKWnv14Su9Bfm9SU9Grut
	3KX12RERn75b3W76qgI51uzCFX035R9+rIF7R
X-Google-Smtp-Source: AGHT+IEEprNR4NF3Q3WnvLiotmlkp3Lt8bivSWWsO+fQy1wY94j5tqAZMqFwzhr1EI+Qy0IGP5aJU7WpBj2TgO+DJIY=
X-Received: by 2002:a05:6902:136d:b0:dcc:97e4:bc61 with SMTP id
 bt13-20020a056902136d00b00dcc97e4bc61mr1324930ybb.57.1711580033859; Wed, 27
 Mar 2024 15:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com> <ZgSTNCP5f+T5VtBI@memverge.com>
In-Reply-To: <ZgSTNCP5f+T5VtBI@memverge.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Mar 2024 15:53:39 -0700
Message-ID: <CAJj2-QEg3+Ztg3rK6FpVVCxSG4DaDPWsO_bha5v5GrJazc5DVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/8] mm: workingset reporting
To: Gregory Price <gregory.price@memverge.com>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Huang Ying <ying.huang@intel.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:44=E2=80=AFPM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Wed, Mar 27, 2024 at 02:30:59PM -0700, Yuanchu Xie wrote:
> > I realize this does not generalize well to hotness information, but I
> > lack the intuition for an abstraction that presents hotness in a useful
> > way. Based on a recent proposal for move_phys_pages[2], it seems like
> > userspace tiering software would like to move specific physical pages,
> > instead of informing the kernel "move x number of hot pages to y
> > device". Please advise.
> >
> > [2]
> > https://lore.kernel.org/lkml/20240319172609.332900-1-gregory.price@memv=
erge.com/
> >
>
> Please note that this proposed interface (move_phys_pages) is very
> unlikely to be received upstream due to side channel concerns. Instead,
> it's more likely that the tiering component will expose a "promote X
> pages from tier A to tier B", and the kernel component would then
> use/consume hotness information to determine which pages to promote.

I see that mm/memory-tiers.c only has support for demotion. What kind
of hotness information do devices typically provide? The OCP proposal
is not very specific about this.
A list of hot pages with configurable threshold?
Access frequency for all pages at configured granularity?
Is there a way to tell which NUMA node is accessing them, for page promotio=
n?
>
> (Just as one example, there are many more realistic designs)
>
> So if there is a way to expose workingset data to the mm/memory_tiers.c
> component instead of via sysfs/cgroup - that is preferable.

Appreciate the feedback. The data in its current form might be useful
to inform demotion decisions, but for promotion, are you aware of any
recent developments? I would like to encode hotness as workingset data
as well.
>
> The 'move_phys_pages' interface is more of an experimental interface to
> test the effectiveness of this approach without having to plumb out the
> entire system.  Definitely anything userland interface should not be
> designed to generate physical address information for consumption unless
> it is hard-locked behind admin caps.
>
> Regards,
> Gregory

