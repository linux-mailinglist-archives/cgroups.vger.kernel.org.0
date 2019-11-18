Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB0100C57
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKRTlc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 14:41:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37011 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKRTlb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 14:41:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id d5so15599189otp.4
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2019 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3o0IsIZAZ7wZG7kNKtDTIC/+CrHgjEOKYqn/GJZgow=;
        b=IP57T3BawVyl+urI2HsWXb3a52KJBX1CVpOTmaws+YDj5nD8X94w/onrfLkCgdDNod
         wN66e0baMmlaayqO4Q3w/oj9JHMWfC3vyWSS1dnr+ktELyPIKg2CPpNZiEgrMSyTARJu
         MfEDJNd3GECOcxNV2Pt9Tm1NrDZr2sdTONBOAecH5v7zpR37Y5ZQyPSy9rL9hesTYa8F
         VW9wgwHLCxTr2sng/rdtXaBI/SkDjMD/wHYF3gAaCdx5bPmqjM/knxvxIJbignzjLPiF
         vrWTBmmunBhanAtLrzaAHfQoJFRV4XID3x2sLXwQ9ZkWVk8rMiynFeppf12qstMIXUF1
         0AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3o0IsIZAZ7wZG7kNKtDTIC/+CrHgjEOKYqn/GJZgow=;
        b=Qlgay1l2i9vkjFlAEKeMR+kFKCG+UgaYvnlDq8vUS+g6BERmujj/NYqEPqFOsZKnwg
         H4tKlIfSGALaOiqnRYcuDX1+SoE9GzeTUDlH8SARXkWmxrTHKSCaMIR1UG1c1KCc5t+7
         VAfEHNsJTxE92XZGeTcSLxceojGdVa8K3pEhmJfys4OzjOa+OUfY5Nx1YDC/6GC6OdjT
         Mv/Su9Zygru/KXy0y9yYsU6oyZ1cXo6lQ2CkxIH8dRjYltSJCGRQbTRLDHA8zXbzPICX
         fKfs81gZv1AVzZ+GgauGXdyaFr8hUI6Tdzyya010sMJ30Le5qEm/wyPojhCQkeDeAiLz
         H8ng==
X-Gm-Message-State: APjAAAXZLzOwuAa6AwSytwcZgdf+PsxJ4s+397fQTL7zRjRNikYp8fCz
        6zbHsKmqXfO7PQUWPH4VCnFgNtFMhf9g0QoXEZezzQ==
X-Google-Smtp-Source: APXvYqzUsgAQBjPOYLPLOEbi+X4F4sQfjR2aYPz7uHf2rwXILQINWQCn1hgtNd0dkCm49mZdpcu3Q2oMsIQ6w0Mchn4=
X-Received: by 2002:a9d:5543:: with SMTP id h3mr715368oti.33.1574106090265;
 Mon, 18 Nov 2019 11:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com> <010d5a90-3ebf-30e5-8829-a61f01b6f620@gmail.com>
In-Reply-To: <010d5a90-3ebf-30e5-8829-a61f01b6f620@gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 18 Nov 2019 11:41:19 -0800
Message-ID: <CAHS8izMWi0BXyiv+Nx4PSV+QkN8beHn0WH9HwwjsMJacwRntvw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
To:     Wenkuan Wang <wwk0817@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> On 10/30/19 9:36 AM, Mina Almasry wrote:
> > /* Must be called with resv->lock held. Calling this with count_only == true
> > * will count the number of pages to be added but will not modify the linked
> > - * list.
> > + * list. If regions_needed != NULL and count_only == true, then regions_needed
> > + * will indicate the number of file_regions needed in the cache to carry out to
> > + * add the regions for this range.
> > */
> > static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>
> Hi Mina,
>
> Would you please share which tree this patch set used? this patch 5/9 can't be
> applied with Linus's tree and add_reservation_in_range can't be found.
>
> Thanks
> Wenkuan

Sorry for the late reply. Locally I have this patchset on top of
linus/master and a patchset that added add_reservation_in_range.

But, this patchset can be rebased on top of this commit with 'minimal'
merge conflicts:

commit c1ca56bab12f3 (tag: v5.4-rc7-mmots-2019-11-15-18-40, github-akpm/master)
Author: Linus Torvalds <torvalds@linux-foundation.org>

    pci: test for unexpectedly disabled bridges

It's the latest mmotm I find on https://github.com/hnaz/linux-mm.git.
My next patchset will be rebased on top mmotm.

>
> > - bool count_only)
> > + long *regions_needed, bool count_only)
> > {
> > - long chg = 0;
> > + long add = 0;
> > struct list_head *head = &resv->regions;
> > + long last_accounted_offset = f;
> > struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> > - /* Locate the region we are before or
