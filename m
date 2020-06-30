Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A820EDA4
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2020 07:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgF3FmU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jun 2020 01:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3FmU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Jun 2020 01:42:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B19C061755;
        Mon, 29 Jun 2020 22:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=10n6fkJT5YFknRXlHwj9gjNGg/R91/iiEmizqFo2Wwo=; b=KS/1RcoO2tBOxUo26C2OeBpqjl
        OB2sVaGqmZWJ+kuE7+75OHOwksmtSEVZNf0KN2lNbbk0YFvsUp8g7rb33mF9Rygtv5wn3lgzZTqcQ
        khfetKq77lCf6uZ5aoegLeRgrbxkfD9th0T/zwET+2XNS6OaFaYwljTfGureLmMCEM6xUmlALsOn6
        64lRKuziJU6P4RoeTfLQ1YJWx3PW+uzU5MLFefV1CBVi5nANFuxRSC3wsLmhnzFHvJOpDKlVhyZlz
        HPSfid7WCsQEdj3nRsPpNptdaSIlJen04FrqdMpG9XIJEksoqGon0zcHUxo8koUf5NuQ15sP9H+H+
        76vP82GA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq929-0007BL-K3; Tue, 30 Jun 2020 05:42:17 +0000
Date:   Tue, 30 Jun 2020 06:42:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] doc: cgroup: add f2fs and xfs to supported list for
 writeback
Message-ID: <20200630054217.GA27221@infradead.org>
References: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 29, 2020 at 02:08:09PM -0500, Eric Sandeen wrote:
> f2fs and xfs have both added support for cgroup writeback:
> 
> 578c647 f2fs: implement cgroup writeback support
> adfb5fb xfs: implement cgroup aware writeback
> 
> so add them to the supported list in the docs.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> TBH I wonder about the wisdom of having this detail in
> the doc, as it apparently gets missed quite often ...

I'd rather remove the list of file systems.  It has no chance of
staying uptodate.
