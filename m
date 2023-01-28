Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE10567F291
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 01:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjA1ABM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 19:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjA1ABL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 19:01:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9E1A947;
        Fri, 27 Jan 2023 16:01:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o13so6123779pjg.2;
        Fri, 27 Jan 2023 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpMQgFXEefyXNUoYBfMtTjQTSA4v50OzgpKHMdUAv0Y=;
        b=YJVu2wQU5OSQO/JJ83OnSM/cP0ME9kQ+Ln4uX/iSrjyTyHBPm/lLCwAS08fPCDvIH5
         FYJFAMDtIBnDI6Y/Lgo+tSwAUgyBHox02ITFyx/Yjt9heQZWbbh/TZQbjG0JlhNunmBp
         TJys6Kx/wJODfbi4I99kcDrMCu5vDURITKTDbIXJDFsFWXjy354q+aip37wplh8eacYV
         MLMOOPz1ndvyucc5eeLPdHjYnUETdqIvq7ocWPuWba/mlCReYqfL/57LUao5JGHeqBYx
         g5EcFuiGCGwFmBXUd2tsQ1eTd5TskPNQBXCkP+hZndDyQI0Y4Ao516BmdG2+bUDoHiR3
         /9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpMQgFXEefyXNUoYBfMtTjQTSA4v50OzgpKHMdUAv0Y=;
        b=Aqdc669rSxeGoVGIbGUwZ1NB/2MOtLdyfZpb7o4mUti3hgVw8nFPXlbLjEDl6TVd8u
         8awVDVd7cx48iPvc9gXvTMeB2ggEybpIDNSNpGajgH/c66tJmEmITjn8e+8dWoV4k14T
         /cbEoyBy6wcldzSeOS7RVGeOpnfFgGl5cVUM1jy9YOEwFwi31FhG/72w4JdaqFXN/wcN
         jlAfsPHz7Aa3UpmCFvL3uNlyXoun01JBH/IhwtB8/pFE0CBH9uhKDQv8l1o1/VhuxNjF
         P0mRP+tWo5QpscRpMg+1+CPXiNGinYRogpuY6BA0T9uRwqB8C7zNMeCLRn1nA5SDswxm
         +5Wg==
X-Gm-Message-State: AO0yUKUciY/6r7TiTxpJxsrexjPMEUU57ZazaDjEEOz4h7KvtXGZOvr7
        tRpkcT8f2XZUPjqlAjr/Chk=
X-Google-Smtp-Source: AK7set9u5VMb+CYGxc6F8/Dy5tWAG18MYE4e7nyhSDS42+D8xKdWJwhUuemZj1JBKueXcXCFwdXjCQ==
X-Received: by 2002:a17:903:189:b0:194:7ba1:938 with SMTP id z9-20020a170903018900b001947ba10938mr27979plg.65.1674864069652;
        Fri, 27 Jan 2023 16:01:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902be1400b00192a8b35fa3sm3402917pls.122.2023.01.27.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:01:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 14:01:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 09/15] blk-rq-qos: make rq_qos_add and rq_qos_del more
 useful
Message-ID: <Y9RlxFAbTLXmdeLV@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-10-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:09AM +0100, Christoph Hellwig wrote:
> Switch to passing a gendisk, and make rq_qos_add initialize all required
> fields and drop the not required q argument from rq_qos_del.  Also move
> the code out of line given how large it is.

Sorry about all the nit picks but can you please separate out the uninlining
into its own patch? Code move + small changes in the same patch can be error
prone.

Thanks.

-- 
tejun
