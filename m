Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3A210645
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2020 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgGAIcg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jul 2020 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgGAIc3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jul 2020 04:32:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B13C03E979;
        Wed,  1 Jul 2020 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vXiGSDx0OBTNUoDDVLCHJpE3R5npVOLQYlpMjYD89gk=; b=qdapIMox4Ek2eTE/n0txbbOjGF
        oJGKiOEgDQ9amafICkn7wMpGQazpixnCsCP9vzB1sWllWfYlQ8DIw/BDrv8it538xchboPP1a3fnT
        /r7lFtLJtFEe6qnkJAw62zmPT8rzrymyJ0nyAnw3cv66pExz0H6f2mtFbMKtbsSNR4N0LR36rhtwO
        F0i0ZUtDzzu+A9TrM/ZBHha+soKQAt4lO4WQQDJtMr2tjHFNu5+PkR/hO/DfBja+fSrsZGFpUIUZL
        IBFfzOqiowRXWGc4J2ORzoUaahAdW3PFVchNzsU3fVXrakWnQC9lWtXr6awjsuselgLhI1YRCo/YC
        rWe3CgMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqYAK-0006UI-BJ; Wed, 01 Jul 2020 08:32:24 +0000
Date:   Wed, 1 Jul 2020 09:32:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] doc: cgroup: add f2fs and xfs to supported list for
 writeback
Message-ID: <20200701083224.GI20101@infradead.org>
References: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
 <20200630054217.GA27221@infradead.org>
 <59265a9d-ee0f-4432-3f86-00d076aeb8e8@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59265a9d-ee0f-4432-3f86-00d076aeb8e8@sandeen.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 30, 2020 at 08:59:34AM -0500, Eric Sandeen wrote:
> On 6/30/20 12:42 AM, Christoph Hellwig wrote:
> > On Mon, Jun 29, 2020 at 02:08:09PM -0500, Eric Sandeen wrote:
> >> f2fs and xfs have both added support for cgroup writeback:
> >>
> >> 578c647 f2fs: implement cgroup writeback support
> >> adfb5fb xfs: implement cgroup aware writeback
> >>
> >> so add them to the supported list in the docs.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> >>
> >> TBH I wonder about the wisdom of having this detail in
> >> the doc, as it apparently gets missed quite often ...
> > 
> > I'd rather remove the list of file systems.  It has no chance of
> > staying uptodate.
> 
> Is there any way for a user to know whether a filesytem does or doesn't
> support it, in practice?

git-grep SB_I_CGROUPWB
