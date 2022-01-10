Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0AB489DBC
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiAJQjK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 11:39:10 -0500
Received: from verein.lst.de ([213.95.11.211]:39298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237500AbiAJQjK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 Jan 2022 11:39:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2F5968AA6; Mon, 10 Jan 2022 17:39:06 +0100 (CET)
Date:   Mon, 10 Jan 2022 17:39:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, tj@kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-cgroup: stop using seq_get_buf
Message-ID: <20220110163906.GA6775@lst.de>
References: <20210810152623.1796144-1-hch@lst.de> <20210810152623.1796144-2-hch@lst.de> <20220107092023.iaz57fai5kj47fqf@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107092023.iaz57fai5kj47fqf@olga.proxmox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 07, 2022 at 10:20:23AM +0100, Wolfgang Bumiller wrote:
>     253:10 253:5 rbytes=0 wbytes=0 rios=0 wios=1 dbytes=0 dios=0
>     ^~~~~~ ^~~~~
> 
> I'm not sure if a separate temporary buffer would make more sense or
> switching back to seq_get_buf?
> Figuring out `has_stats` first doesn't seem to be trivial due to the
> `pd_stat_fn` calls.
> 
> Or of course, just include the newlines unconditionally?
> 
> Unless seq_file has/gets another way to roll back the buffer?

No, there is no good way to roll back the buffer.
