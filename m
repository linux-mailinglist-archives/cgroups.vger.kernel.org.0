Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3A10669B
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2019 07:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVGqu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Nov 2019 01:46:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKVGqu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Nov 2019 01:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=56NFxkQajPmvDuPj0+mInO1dB9fS9ic2p3t8jjTTnT8=; b=EjUXwdtNnarR65rFcGxuixa2O
        e7UMLMjrC758Xq1yeX6ddusBTj36Wzx3nKqKwEWkTt/f30C1Oi+1S+efS4YieSrU3XWOqQgqzRAp7
        hnFB5NFxatYKTBlTm200UgQHvnqlmKasGp/4GdRbSRDeNgEbxv1PXlaXRcqVp8dvyhwhyDmWa1npX
        0MUJo17reqmttsVjpgr9kybJWBvj8xpAG9VdCyM/vF0HKLXhtA7SfIEke6JxzvXUPot5Y7FB3ayU7
        VI4rz7FUkVuP3mEkPNL1cu6Q7kO1O7SrzH2wKLYIhTda/+iaffzu+TT7YKgOj5TnanRJ0VOwNvhjk
        j5LmPxgmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY2iL-0006WV-KR; Fri, 22 Nov 2019 06:46:45 +0000
Date:   Thu, 21 Nov 2019 22:46:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Rong Chen <rong.a.chen@intel.com>
Subject: Re: [PATCH v3 2/7] mm/lruvec: add irqsave flags into lruvec struct
Message-ID: <20191122064645.GA11261@infradead.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 16, 2019 at 11:15:01AM +0800, Alex Shi wrote:
> We need a irqflags vaiable to save state when do irqsave action, declare
> it here would make code more clear/clean.

This patch is wrong on multiple levels.  Adding a field without the
users is completely pointless.  And as a general pattern we never
add the irqsave flags to sturctures.  They are an intimate part of the
calling conventions, and storing them in a structure will lead to
subtile bugs.
