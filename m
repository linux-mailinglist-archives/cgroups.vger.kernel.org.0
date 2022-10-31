Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8305613CB1
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 18:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJaR5L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJaR5J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 13:57:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A9101E7;
        Mon, 31 Oct 2022 10:57:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso16588511pjg.5;
        Mon, 31 Oct 2022 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oc04HoeSDvyZ00MBhetf0mLZqQi+t7KUCqjcURmh3jw=;
        b=jQlWLfja+D7d4A9Ytn7AA5c2SFo8aoOuU1Y/iuH5dqmpB7L2WpenUoZwgEhkhQJKpM
         rmfidvSjKdJu39KNzdOvPi5sCF8O3MWHCDs+6scuYyxo677vuN9UcAc9j0cmrfZq8tu+
         MU/ZdmUHZEI0Z2QO4hVcdxRZ1N5BKiBmDu76ViwKpVab6tl09FkylvVAUSKVy9Tk49aH
         LK2lixcaFn8/QVi7vPwHU2Pb9W7L337sd/G+3AbwRvRrhZKfstcL+/4mKhXg5il/n0tv
         cvhEfobQr07ErMCtNF4yNklmm2lTTJSEs6I+ishnlXDxpR7BhssFcyYDyBpjXEkK0u/a
         yZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc04HoeSDvyZ00MBhetf0mLZqQi+t7KUCqjcURmh3jw=;
        b=dP2jfUZkG1IefxpCFXT6VLG+5j3HtbUuKEf9ZKfIiSLPSdmJJoxk2DPZ7vaYvh+gia
         J3wsfU/4tySsDqAM2WBZDvkKFJBI5ig9oaLjmkC6Am6c6WBMP30LUlfkspl8z4PgmA/m
         VNC7/mI2dTfZXCde2BiJym8jHIBm7wCzkBPK1rSqZmXTeHW6D25fhf+qglVXDTJKPFGO
         3aHkzO+89kB2qju63bJl94ELp/fUAvMkyY0/nUE2v4xw8Ikgiel0b2w5xY8kdGn7R/1n
         42jPaEAFSrMaIFA4rIE77RuY5E2F/+mQTd0DwndOoTHAzLbzFSQg3n5hw9LmZHH6qTfm
         DJOw==
X-Gm-Message-State: ACrzQf0zcrNTaz9E8iZ2vtLi43oDzTSW81nh1m94pHh2DNupFI0BMnvt
        9CPwN9KdmN3bR0uwjEaO9dw=
X-Google-Smtp-Source: AMsMyM5dvCT/impuB0g5b/LaE1mQEgVuKLyFRrRiJ1Ky5Wkw5zJ8tbHDjRCc3Y1ttCI1aD4LoJ+rmA==
X-Received: by 2002:a17:903:2283:b0:187:21f6:fde2 with SMTP id b3-20020a170903228300b0018721f6fde2mr6297961plh.49.1667239027195;
        Mon, 31 Oct 2022 10:57:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id e15-20020a056a0000cf00b00550724f8ea0sm4888641pfj.128.2022.10.31.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:57:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 07:57:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Message-ID: <Y2AMcSPAJpj6obSA@slm.duckdns.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1++fLJXkeZgtXR2@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 31, 2022 at 05:24:28AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 12:45:20PM +0100, Jiri Slaby (SUSE) wrote:
> > Cast the enum members to int when printing them.
> > 
> > Alternatively, we can cast them to ulong (to silence gcc < 12) and use %lu.
> > Alternatively, we can move VTIME_PER_SEC away from the enum.
> 
> Yes, either split the enum or just use a define.  But casts are a big
> code smell and should be avoided if there is a reasonable alternative.

enums are so much better for debugging and other instrumentation stuff. The
only requirement for the enum types is that they're big enough to express
all the members and we can use whatever printf format letter which matches
the type in use. The problem here is that the compiler behavior is different
depending on the compiler version, which kinda sucks.

I suppose the most reasonable thing to do here is just splitting them into
separate enum definitions. Does anyone know how this behavior change came to
be? Do we know whether clang is gonna be changed the same way?

Thanks.

-- 
tejun
