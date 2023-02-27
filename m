Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4926A43CB
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 15:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjB0OJA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 09:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjB0OI7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 09:08:59 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFEB975F;
        Mon, 27 Feb 2023 06:08:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8E5667373; Mon, 27 Feb 2023 15:08:47 +0100 (CET)
Date:   Mon, 27 Feb 2023 15:08:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        aherrmann@suse.de, mkoutny@suse.com, linux-kernel@vger.kernel.org,
        hch@lst.de, leit@fb.com
Subject: Re: [PATCH v2] blk-iocost: Pass disk queue to ioc_refresh_params
Message-ID: <20230227140847.GA18644@lst.de>
References: <20230227135610.501884-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227135610.501884-1-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Breno,

and sorry for the late reply.  This looks correct to me, but I'd
be much happier if the disk was passed in instead of the request_queue
as that's where we're generally heading.  If you don't have time to
respin I could live with this version for a fix, though.
