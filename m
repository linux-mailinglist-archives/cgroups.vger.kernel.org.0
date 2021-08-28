Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C93FA75B
	for <lists+cgroups@lfdr.de>; Sat, 28 Aug 2021 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhH1Tik (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 Aug 2021 15:38:40 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:21994 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhH1Tik (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 28 Aug 2021 15:38:40 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id DDA7219F58A;
        Sat, 28 Aug 2021 21:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Eg7jIAyWdnvSe9BizhWpgYxEQwOfxC+45v1t71BBM2Q=; b=FIrTWsfqFMjx6IsmX3sH67wt/S
        vrvMIZYejksNVNuxGibFxvlSZWDrxZBNEwb87X5iSIWPcWYF7oI7JA58Glx/pwiIlu3d56yrnAgJt
        tfnGq0tRMzjjO1IbbrI6v+kZ3KXaWAjHbPne5Aee8A2zi6JNwgJDXliGbP7DvDPJdGS8=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mK48j-0005iQ-KD; Sat, 28 Aug 2021 21:37:17 +0200
Date:   Sat, 28 Aug 2021 21:37:17 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     almasrymina@google.com, mike.kravetz@oracle.com,
        cgroups@vger.kernel.org, guillaume@morinfr.org, linux-mm@kvack.org
Subject: Re: [BUG] potential hugetlb css refcounting issues
Message-ID: <20210828193716.GA21491@bender.morinfr.org>
Mail-Followup-To: almasrymina@google.com, mike.kravetz@oracle.com,
        cgroups@vger.kernel.org, guillaume@morinfr.org, linux-mm@kvack.org
References: <8a4f2fbc-76e8-b67b-f110-30beff2228f5@oracle-com>
 <20210827225841.GA30891@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827225841.GA30891@bender.morinfr.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 28 Aug  0:58, Guillaume Morin wrote:
> > I am not sure about the above analysis.  It is true that
> > hugetlb_cgroup_uncharge_page_rsvd is called unconditionally in
> > free_huge_page.  However, IIUC hugetlb_cgroup_uncharge_page_rsvd will
> > only decrement the css refcount if there is a non-NULL hugetlb_cgroup
> > pointer in the page.  And, the pointer in the page would only be set
> > in the 'deferred_reserve' path of alloc_huge_page.  Unless I am
> > missing something, they seem to balance.
> 
> Now that you explain, I am pretty sure that you're right and I was
> wrong.
> 
> I'll confirm that I can't reproduce without my change for 2.

Confirmed. With the patch for the first issue, the issue is indeed
fixed. I must have messed up something during my testing...

Anyway, this is the change for 1:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8ea35ba6699f..00ad4af0399b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4033,8 +4033,11 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	 * after this open call completes.  It is therefore safe to take a
 	 * new reference here without additional locking.
 	 */
-	if (resv && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+	if (resv && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+		if (resv->css)
+			css_get(resv->css);
 		kref_get(&resv->refs);
+	}
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)

-- 
Guillaume Morin <guillaume@morinfr.org>
