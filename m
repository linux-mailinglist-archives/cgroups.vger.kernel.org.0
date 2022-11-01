Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1986150D1
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiKARfq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKARfp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 13:35:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D331FC
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 10:35:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j12so14219711plj.5
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZOlmrIU3zPJm8I8RxpQWnf+DIcXmvWnjdo0U6pMluk=;
        b=llxNgOh5raFgOVdU0BfM5xVW8e3SqWPzVhi+AOt9T2XEOLOGBiIc2jTNpUvujTZXlC
         Hixqz8VU5pqwE0yuovTSYrf+0XoNzjSYI5OuN5NhYwGKcmFuAdTpfOBR5vTjMjFe1QFe
         WbdDYlfcFrBT3CYLwUWLMdJq6UmvKybwwvu6B5F6JpY1myK6PETXeQs8LkmMPgXL55ju
         DHjUqzG2H8Q8UqfR45/lXsV4BGnOzl9VRgrDL7JZrpRVSkImFUZgcEUVl2qhR63HOXol
         h3gTfHzWGCeNMbJ67/5d1Yg+rvH9dkKsCNeMHDQoGfUtkKytgF7XzKNkAsWzP0MfGHM9
         TIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZOlmrIU3zPJm8I8RxpQWnf+DIcXmvWnjdo0U6pMluk=;
        b=BbZ4+dtIVSv1HpRv83c0w1HOfmEuuQO2R/+S5YnCU3CTW1B1ki4oIx9geyS1DMsLUN
         XXMVoxPG5P9VHHqFv0OIh8c8tNWSvQ6zRSzFyTEOeCVnG8wnjeNFIXO83h7Ua1qA7Vr4
         aGHolIkF53MCKljik6KcHCMCtKaOTU1Z48uhAtCDepdwh0hNVvDjeZPbzeLixY7Vk6k5
         EEHP/hyO0T0M4XwxPZL2Kz/njB0ad85oQ1Ee2HdlxdHWCXxFLYpZnBJ5i2NH5lan1har
         zFNi4avZmTCSPhp2dujf2qdq4b89f9/uVPj4zPG3aBRKtw1t81ECl88m7CeGfY1SZxYC
         oG/A==
X-Gm-Message-State: ACrzQf3PpXJW/XLOh+ZXLXglFeuN5hxmBO+l5ituxd5Ikaoke2DAWFJY
        zMI6S8LcGqc+3HswqZVKPNg=
X-Google-Smtp-Source: AMsMyM7gsEGTkcBQ6m+5YprSzTDMy5FVdBJ5LVxLBLkbo43csN3/8FTNIYffhAINev2KPn34q0W7bA==
X-Received: by 2002:a17:903:183:b0:184:5b9a:24e7 with SMTP id z3-20020a170903018300b001845b9a24e7mr20582359plg.79.1667324144829;
        Tue, 01 Nov 2022 10:35:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f37f])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7950e000000b00560a25fae1fsm6761813pfp.206.2022.11.01.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:35:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 07:35:42 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: clarification about misc controller and capacity vs. max
Message-ID: <Y2FY7pVKWQgDE2Gk@slm.duckdns.org>
References: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
 <Y2FPSqOaQGnISvXu@slm.duckdns.org>
 <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
 <Y2FR6SYazbxyK5nj@slm.duckdns.org>
 <f678f325b47ac64e101c0ccea54c1cd1c4ea4206.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f678f325b47ac64e101c0ccea54c1cd1c4ea4206.camel@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 01, 2022 at 05:11:13PM +0000, Accardi, Kristen C wrote:
> This is a bit of a deal breaker for the use of the misc controller for
> SGX EPC memory - we allow overcommit of the physical EPC memory as we
> have backing RAM that is used to swap. Would you be amenable to having
> a flag to ignore the total capacity value and allow for overcommit of
> the resource? If not I feel like we don't have a choice but to create a
> new controller.

Yeah, for sure. Maybe just introduce a special value (prolly u64 max) that
says that there's no limit. Or maybe just set it to total physical memory?

Thanks.

-- 
tejun
