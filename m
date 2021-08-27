Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E03FA1A8
	for <lists+cgroups@lfdr.de>; Sat, 28 Aug 2021 00:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhH0XAG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 19:00:06 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:9032 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhH0XAF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 27 Aug 2021 19:00:05 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 9E29819F4EA;
        Sat, 28 Aug 2021 00:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7DJVtMpzm9oxuyqntlCJVVhZoeJfYs38uQ3cZd0skFs=; b=4rlRF3Hd5lDAg9L8xjFB/XxBl8
        k1Mmg1v5cHtDuzaaYMcznDw4/DDEOGB3yNMe9scXQmd32494EbEXscjyb0dajfSnWIwpeR11/pufy
        aZpJf7iVXLCTGi4Q6qkXqQnASllosSdNLgXpKv3HZp+xp/Xnnt0RlkQItUEgiR7FlH4U=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mJko7-0008O4-B4; Sat, 28 Aug 2021 00:58:43 +0200
Date:   Sat, 28 Aug 2021 00:58:43 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     almasrymina@google.com, mike.kravetz@oracle.com,
        cgroups@vger.kernel.org, guillaume@morinfr.org, linux-mm@kvack.org
Subject: Re: [BUG] potential hugetlb css refcounting issues
Message-ID: <20210827225841.GA30891@bender.morinfr.org>
Mail-Followup-To: almasrymina@google.com, mike.kravetz@oracle.com,
        cgroups@vger.kernel.org, guillaume@morinfr.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4f2fbc-76e8-b67b-f110-30beff2228f5@oracle-com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Mike,

I really appreciate the quick reply

Mike Kravets wrote: 
> There have been other hugetlb cgroup fixes since 5.10.  I do not believe
> they are related to the underflow issue you have seen.  Just FYI.

Yes, I am aware. Actually I did my best to look at all recent changes
not backported to 5.10 and couldn't find anything related. I tried to
cherry-pick a couple of fixes in case but the bug did not go away.

> However, when a vma is split both resulting vmas would be 'owners' of
> private mapping reserves without incrementing the refcount which would
> lead to the underflow you describe.

Indeed and I do know that programs running on my reproducer machines do
split vmas.

>> 2. After 08cf9faf75580, __free_huge_page() decrements the css
>> refcount for _each_ page unconditionally by calling
>> hugetlb_cgroup_uncharge_page_rsvd().  But a per-page reference count
>> is only taken *per page* outside the reserve case in
>> alloc_huge_page() (i.e hugetlb_cgroup_charge_cgroup_rsvd() is called
>> only if deferred_reserve is true).  In the reserve case, there is
>> only one css reference linked to the resv map (taken in
>> hugetlb_reserve_pages()).  This also leads to an underflow of the
>> counter.  A similar scheme to HPageRestoreReserve can be used to
>> track which pages were allocated in the deferred_reserve case and
>> call hugetlb_cgroup_uncharge_page_rsvd() only for these during
>> freeing.

> I am not sure about the above analysis.  It is true that
> hugetlb_cgroup_uncharge_page_rsvd is called unconditionally in
> free_huge_page.  However, IIUC hugetlb_cgroup_uncharge_page_rsvd will
> only decrement the css refcount if there is a non-NULL hugetlb_cgroup
> pointer in the page.  And, the pointer in the page would only be set
> in the 'deferred_reserve' path of alloc_huge_page.  Unless I am
> missing something, they seem to balance.

Now that you explain, I am pretty sure that you're right and I was
wrong.

I'll confirm that I can't reproduce without my change for 2.

Thank you,

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
