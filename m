Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B426A45D9
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 16:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB0PTK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 10:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0PTI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 10:19:08 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC27694;
        Mon, 27 Feb 2023 07:19:07 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D31967373; Mon, 27 Feb 2023 16:19:03 +0100 (CET)
Date:   Mon, 27 Feb 2023 16:19:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, tj@kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de, josef@toxicpanda.com,
        aherrmann@suse.de, mkoutny@suse.com, linux-kernel@vger.kernel.org,
        leit@fb.com
Subject: Re: [PATCH v3] blk-iocost: Pass gendisk to ioc_refresh_params
Message-ID: <20230227151903.GA23921@lst.de>
References: <20230227151252.1411499-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227151252.1411499-1-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
