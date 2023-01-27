Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317FD67F194
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 23:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjA0W7X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 17:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjA0W7X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 17:59:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86D118;
        Fri, 27 Jan 2023 14:59:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lp10so5982380pjb.4;
        Fri, 27 Jan 2023 14:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGAfOWe0SVdQsDd5eQVWsjHBkUXpqcdLORzkGX51TD4=;
        b=UxC+CFvuSnuV2UzyNwU2S/v/4cv76y60avmTZr83q6O2y6KXdHH1ohB+6X2mgxOmG3
         IBkV3bxAkLptT7RCK0sRjfXIFLSghj+b5KOXiOhL7J4KC8zNPwGEvdCzDjWpol22D8aL
         dCOXAU+zQUaE4tu1+fUDq4clpiz2WDb6RZiR8SNRqFjJQBlBvffO/RwqZ8N8MGZW923w
         jQjrVPQjlwA01Jfn+PAaqtlJpvZxBgk3UePk0EO2PcrMfAbznBUemtT/PcQBn4/f9F27
         LOaMLDu/2r9C4Wfsi44ILdVgD18JITmWMTF09g4NDOh/v14tWhopqFJ2kD/wIVXkS+aj
         T2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGAfOWe0SVdQsDd5eQVWsjHBkUXpqcdLORzkGX51TD4=;
        b=sAkhlz8Oxv5/KacwKmAz4ioVtXlT2QN2u3qZAcgfMdcMYmMAh/dyuK0w9OYb9CuXW2
         UbaMq6InHVJh38tJJq1EkoeGCYdAMJwGOhKM6EO221EmUQlIrERytuRmWZyhZ/3c71qb
         H2WPmlNG8elkOua0UApobb9CFAAXCsy0FS5mVSS1o3IQeZzWbIBtvPL/4i2IA1JAWiQ7
         WuXpbF9mBLbtQpp3DRJlcDLXmqigas/3fSQ433Bhe5odqpD24AadMD3nNWsqDFOYUAKQ
         vGo54FUPj2F4LzpVUDfyUcUVcZGCDsZmNcpR/FIUva0JEdJgMG03wytXZL8Om9SsqYwz
         ABUQ==
X-Gm-Message-State: AFqh2kpD+RYsGRxM1iT5/eKlJFVAI5WymxtrjkiC7bTgiLpH3T+X1OqR
        9IOPJFexanb4NZIPXZNKG6lK1agMjmI=
X-Google-Smtp-Source: AMrXdXtQ73cQM7in7zSsbwhUlWiyJXizTwlmhfy8gbnppRg99C3gkRLTf2FBObBynockFic4wodoPQ==
X-Received: by 2002:a17:90a:51e4:b0:219:818f:9da3 with SMTP id u91-20020a17090a51e400b00219818f9da3mr44774347pjh.17.1674860361932;
        Fri, 27 Jan 2023 14:59:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r63-20020a17090a43c500b0022bacef5fbdsm5423195pjg.52.2023.01.27.14.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:59:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 12:59:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 03/15] blk-cgroup: delay blk-cgroup initialization until
 add_disk
Message-ID: <Y9RXSHQtpLKFLDOq@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-4-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:03AM +0100, Christoph Hellwig wrote:
> There is no need to initialize the group code before the disk is marked
                                     ^
				     cgroup

-- 
tejun
