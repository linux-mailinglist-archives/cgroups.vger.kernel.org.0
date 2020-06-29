Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68120D21C
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgF2Sqi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:46:38 -0400
Received: from verein.lst.de ([213.95.11.211]:58878 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbgF2Sqg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8689868B02; Mon, 29 Jun 2020 10:08:31 +0200 (CEST)
Date:   Mon, 29 Jun 2020 10:08:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: drive-by blk-cgroup cleanups
Message-ID: <20200629080831.GA32117@lst.de>
References: <20200627073159.2447325-1-hch@lst.de> <SN4PR0401MB3598A198ACA6126D96E949B59B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598A198ACA6126D96E949B59B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 29, 2020 at 08:05:07AM +0000, Johannes Thumshirn wrote:
> Btw what ever happened to https://lore.kernel.org/r/20200430150356.35691-1-johannes.thumshirn@wdc.com?

You'll have to ask Jens :)  Note that your patch 2 overlaps with this
series.  I thik my version is a little nicer, given that
blkcg_bio_issue_check is a very strange function doing multiple things
as-is.

