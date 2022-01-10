Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A768489DBD
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiAJQjb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 11:39:31 -0500
Received: from verein.lst.de ([213.95.11.211]:39300 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237610AbiAJQja (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 Jan 2022 11:39:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4494268AFE; Mon, 10 Jan 2022 17:39:28 +0100 (CET)
Date:   Mon, 10 Jan 2022 17:39:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk-cgroup: always terminate io.stat lines
Message-ID: <20220110163928.GB6775@lst.de>
References: <20220110153457.5894-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110153457.5894-1-w.bumiller@proxmox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
