Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD9121BB3
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 22:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLPV1t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 16:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfLPV1t (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Dec 2019 16:27:49 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CF32465E;
        Mon, 16 Dec 2019 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576531668;
        bh=BhlkN15I6oRQ9j0RVDNy2nn7wwQPEwlGJZaAA+116hQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xSs0TdYtzIAZihBPaaZPi063Tn6w8NZU3UcPuI9UrI/OWgZYcyEhVh/0C1t8XIbAd
         rlRwN6gQ3zqthfjMNAQ7HUp99pHT9lv/xD6lns8oBRC5K0AAOSfcY0gb/lATzpa0tI
         ptkJnnxA9oBYPkYNfyCN3n5sGOOgiv8pOnhdNskY=
Date:   Mon, 16 Dec 2019 13:27:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>, cgroups@vger.kernel.org,
        mike.kravetz@oracle.com, mkoutny@suse.com, lizefan@huawei.com,
        hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v6] mm: hugetlb controller for cgroups v2
Message-Id: <20191216132747.1f02af9da0d7fa6a3e5e6c70@linux-foundation.org>
In-Reply-To: <20191216204348.GF2196666@devbig004.ftw2.facebook.com>
References: <20191216193831.540953-1-gscrivan@redhat.com>
        <20191216204348.GF2196666@devbig004.ftw2.facebook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 16 Dec 2019 12:43:48 -0800 Tejun Heo <tj@kernel.org> wrote:

> On Mon, Dec 16, 2019 at 08:38:31PM +0100, Giuseppe Scrivano wrote:
> > In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> > the lack of the hugetlb controller.
> > 
> > When the controller is enabled, it exposes four new files for each
> > hugetlb size on non-root cgroups:
> > 
> > - hugetlb.<hugepagesize>.current
> > - hugetlb.<hugepagesize>.max
> > - hugetlb.<hugepagesize>.events
> > - hugetlb.<hugepagesize>.events.local
> > 
> > The differences with the legacy hierarchy are in the file names and
> > using the value "max" instead of "-1" to disable a limit.
> > 
> > The file .limit_in_bytes is renamed to .max.
> > 
> > The file .usage_in_bytes is renamed to .current.
> > 
> > .failcnt is not provided as a single file anymore, but its value can
> > be read through the new flat-keyed files .events and .events.local,
> > through the "max" key.
> > 
> > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> This can go through either the mm tree or the cgroup tree.  If Andrew
> doesn't pick it up in several days, I'll apply it to cgroup/for-5.6.
> 

Thanks, I grabbed it.

Giuseppe, yuo presumably have test code lying around.  Do you have
something which can be tossed together for tools/testing/selftests/? 
Presumably under cgroup/.

We don't seem to have much in the way of selftest code for cgroups.  I
wonder why.
