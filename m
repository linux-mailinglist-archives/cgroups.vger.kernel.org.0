Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06AC6A4532
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjB0OwW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 09:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0OwV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 09:52:21 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE02202C;
        Mon, 27 Feb 2023 06:52:19 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id l25so6528144wrb.3;
        Mon, 27 Feb 2023 06:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ig4nk3MPcVVXmPaI5r91h49D/cIs37xSeKPwjDDQdOY=;
        b=sYUD3oOmJTSqgfeF17KXwqzFpAkgQ0+n7xYj08RVLQ7K1HZoIasTJnaFkdW6iOmHKL
         xcB52jWN+ZUBaZ7cu18qG4+n43jSRjYDVqhuRyauGdJfp2xZRultfqbjaM0RCC+fLe3M
         6CgFAYc5cg0fZKtWpF7oy5adWDWhxgqtWtfXIy+lVUMNfNnMybjSAtoEwxqQamjIEH/Y
         D1VtXArTD3+gkgIOmuDuXtAUyIgqGFyGJ79uwZKqdnuKY/tqSHaQz3fk92gKmsdBoiZl
         bXc0q7PbtRCbEDWO3s+vKGjFSGpwPMCgin2NHwC7O89zajQvmHG9tJsW+LHCZEJ1ZVl2
         k7aQ==
X-Gm-Message-State: AO0yUKUmIq/oMDI6cGegqR4WfcTwMollSsxpKtSyJrtgMAkteG3bhw1g
        2j1mGcYI6+MPTIAvrBw6NNs=
X-Google-Smtp-Source: AK7set8vnaLOnleLv10OV+Ul8uVDdYp+NJiQ5huJjqDq6AiKz12FrbsCZnQjMTw3QRb3OOR6627K9g==
X-Received: by 2002:a5d:570e:0:b0:2bf:d940:29b6 with SMTP id a14-20020a5d570e000000b002bfd94029b6mr21925697wrv.54.1677509537875;
        Mon, 27 Feb 2023 06:52:17 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1136:1486:5f6c:3f1:4b78? ([2620:10d:c092:400::5:e15])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm8415664wms.2.2023.02.27.06.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 06:52:17 -0800 (PST)
Message-ID: <2e8c8937-b027-8b20-a16b-3dfed8217ad2@debian.org>
Date:   Mon, 27 Feb 2023 14:52:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Cc:     leit@meta.com, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, aherrmann@suse.de, mkoutny@suse.com,
        linux-kernel@vger.kernel.org, leit@fb.com
Subject: Re: [PATCH v2] blk-iocost: Pass disk queue to ioc_refresh_params
To:     Christoph Hellwig <hch@lst.de>
References: <20230227135610.501884-1-leitao@debian.org>
 <20230227140847.GA18644@lst.de>
From:   Breno Leitao <leitao@debian.org>
In-Reply-To: <20230227140847.GA18644@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Christoph,

On 27/02/2023 14:08, Christoph Hellwig wrote:
> Hi Breno,
> 
> and sorry for the late reply.  This looks correct to me, but I'd
> be much happier if the disk was passed in instead of the request_queue
> as that's where we're generally heading.  If you don't have time to
> respin I could live with this version for a fix, though.

No worries, I can definitely do a respin passing the disk instead of
request_queue.

I hope to send a v3 in the next few hours.

