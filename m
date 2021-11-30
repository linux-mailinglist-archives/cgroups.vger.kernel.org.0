Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316E462CFC
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 07:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhK3GrU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 01:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhK3GrT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Nov 2021 01:47:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B013C061574;
        Mon, 29 Nov 2021 22:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ddVaDeU0Jvjl+Fe4JdR7EXlePtBzgo3q/f4WhbMSGg8=; b=zvinEgKsMo0VOvoNk6EqMfOTHA
        is82Ygjn7cQ+TV0DGLvAG6poLX6o+vpcCAYRCTLd88ob7yBNd5nqgWWxlpxCkIrsyFQ+6AmYq9EW/
        d0QgibAE31oSrDEWHigEeapOMOBq4LBXpJlHIxQoVWyVf8wuvLa5kfh64D2H/VoDuGk6YGydf2/lr
        l7T+8eMDaNU2lWYjmFDA7RCRe41Uikv8r2FMh6WNsZpYMPCeLrJY5AUecVjRLlYBRp3x15S6XwUXJ
        FQWZ85WTS/KJX22zZnBVlxpUlhFuNBh6I69Fz5zquYhAT0xjYOe00vvqHR9vE+PkyIA3ZHr8g8igp
        RdvGHtOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrwrv-003pfI-8E; Tue, 30 Nov 2021 06:43:59 +0000
Date:   Mon, 29 Nov 2021 22:43:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <YaXIL3Kkwa56ANMe@infradead.org>
References: <20211130011730.2584339-1-yukuai3@huawei.com>
 <20211130011730.2584339-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130011730.2584339-3-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This look fine to me, but I think someone who actually knows the
throttle code also needs to look over it.
