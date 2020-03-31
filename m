Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B491E19910C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgCaJQq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 05:16:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbgCaJQp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 05:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dAEAaiyYMafUZFXucEHFMwj9eNivSkJsj+WW8FmIfy0=; b=WDE48/qkkHgSzTYDWPtabW2BIr
        QId90vMWhyZ52q84KyJn1KuMAWJMJlgbm9nleLyenJATRTgWQTOPXCI2lrEmA2Wc2PzCqdHsyPsHF
        ePZB7DcFSeEIbLRsUZXU44hSzXY2ouUh4MfwnTFG+rD36iMKNqL87gb71OGczLhq6a2iXvtvIx73o
        6hFwaOmKiJUoC05xpHEjbJOS1LOYg9GJgw3jHCZtoBL2PxnZ5qFF2c6TVZHtHPQ6Y+P3nHrg51PK4
        PNCU65ImZZS0Qn4A+1QdIlrBcyfwqAmQssODULy2UAERzJcY7UeOiGlKlFn5lhnBDrtrL+7RiGPqV
        dekOQ0Tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJD0m-0004fI-3F; Tue, 31 Mar 2020 09:16:44 +0000
Date:   Tue, 31 Mar 2020 02:16:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] bio: track timestamp of submitting bio the
 disk driver
Message-ID: <20200331091644.GB12040@infradead.org>
References: <20200327062859.GA12588@192.168.3.9>
 <20200331082505.GA14655@infradead.org>
 <CAA70yB5cWESKW600Lwoi8toPaiDtOVH53P8GSou6uukmX5mvgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA70yB5cWESKW600Lwoi8toPaiDtOVH53P8GSou6uukmX5mvgQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 31, 2020 at 04:45:33PM +0800, Weiping Zhang wrote:
> Christoph Hellwig <hch@infradead.org> 于2020年3月31日周二 下午4:25写道：
> >
> > On Fri, Mar 27, 2020 at 02:28:59PM +0800, Weiping Zhang wrote:
> > > Change-Id: Ibb9caf20616f83e111113ab5c824c05930c0e523
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> >
> > This needs a commit description and loose the weird change id.
> >
> OK, I rewirte commit description, it record the timestamp of issue bio
> to the disk driver,
> then we can get the delta time in rq_qos_done_bio. It's same as the D2C time
> of blktrace.
> > I also think oyu need to fins a way to not bloat the bio even more,
> > cgroup is a really bad offender for bio size.
> struct request {
>     u64 io_start_time_ns;
> also record this timestamp, I'll check if we can use it.

But except for a few exceptions bios are never issued directly to the
driver, requests are.  And the few exception (rsxx, umem) probably should
be rewritten to use requests.  And with generic_{start,end}_io_acct we
already have helpers to track bio based stats, which we should not
duplicate just for cgroups.
