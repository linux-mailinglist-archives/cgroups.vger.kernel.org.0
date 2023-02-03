Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1BB688BA4
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 01:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjBCASA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 19:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBCAR7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 19:17:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5277673058;
        Thu,  2 Feb 2023 16:17:57 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso3429149pjb.4;
        Thu, 02 Feb 2023 16:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ2SE0xgSABc11mXNWl+oiadQkiomrK4JUHBAot+aRE=;
        b=Ej/GrPr2RzCgO9vpRQBNclgQuceQb6QIjdnDFM0M4Dcq6P/sNAuyxhNH0LXuXbxfyc
         g2pIvuuGTSmqfU0z2dOlCmoP/Ec/h3m9r/hNF0m5hpUt4gJdQ8RGoBTEZw9CIPTRJK93
         wlK1JajBcwddE+Xd9elPV7yHz2nlt12lHnPNonYfaunszbwhJMVjZUBGxuhdsUUccUq7
         1imFJjOP8ZnJUHgaCrji200rJik7ZgaX/5nrxUNfOUcKbek4xbOhbJexnnH8DITZvPDS
         /F9t8tixH+O5dP0Lt8w66q/FdMknBH9RWUkDlMRQGXLngA8AHLmO5piYP8pdmsZEbTmo
         BONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ2SE0xgSABc11mXNWl+oiadQkiomrK4JUHBAot+aRE=;
        b=TWZQyqDxLXXryersGrnIPCNojA0pza2JrGAyycPRipWF+DEvwdU5TE8WSSbe3zTBAj
         zIFH5JqXuJOHpD+/zqTuYj8xBHSOZuF9QkatavzcYThc3UFyMspz1SzGkQ7WD+NIoRE+
         eD7VhIo4gRXy7to5y6OdQhQmGgoHDwvHv5j5IUYMG/O+Kw1s6I8Z0DDE4x8pBQT6wRIZ
         bHeBDMW5dUBNp6NOSTvpGY6XgbjpLUVzjyFsD44NykDBjq1kX5nyYgH6AOhDOMZHbspD
         ov3ALyohcjdmyTObINDe8VdSUxxRp6eunGO5akzYKCZPIdwLJ6h88htXXskCacWMDq2j
         yV2g==
X-Gm-Message-State: AO0yUKW1qK67sByU3yEP1Hdpda7KbUmhfiFb7VjvJgeaHbzt0pMoou1z
        eXbdTh4aYej+K1HyEswbSfI=
X-Google-Smtp-Source: AK7set942ji5RPsRjjgk2TCqb3hyH1omPEFkFiu+U7VmM6baqdOflJoekFtkTSO8liPJIbG5oJkTAw==
X-Received: by 2002:a17:902:e84d:b0:197:9184:34c6 with SMTP id t13-20020a170902e84d00b00197918434c6mr10639090plg.55.1675383476634;
        Thu, 02 Feb 2023 16:17:56 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090331ce00b0019619f27525sm233636ple.302.2023.02.02.16.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:17:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 14:17:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 07/19] blk-cgroup: store a gendisk to throttle in struct
 task_struct
Message-ID: <Y9xSs0Gf8Qcr9R7w@slm.duckdns.org>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134123.2656505-8-hch@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 02:41:11PM +0100, Christoph Hellwig wrote:
> Switch from a request_queue pointer and reference to a gendisk once
> for the throttle information in struct task_struct.
> 
> Move the check for the dead disk to the latest place now that is is
> unbundled from the reference grab.

The change looks fine to me but can you please separate out the dead disk
test change to its own patch and explain why?

Thanks.

-- 
tejun
