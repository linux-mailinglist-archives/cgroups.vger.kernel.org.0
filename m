Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240C0674F4C
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 09:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjATIVB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 03:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjATIVA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 03:21:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFB14CE7C;
        Fri, 20 Jan 2023 00:20:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b10so4920061pjo.1;
        Fri, 20 Jan 2023 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWumMt67h30adlz6lQSPu1lCC0nb5fEUVVbRzQpjcvo=;
        b=XBjIbyJ7l70xuIKKldJeINNaWQ8MoXJ2Y/IACHV3SKahghX1ofznCaFuqGW1pcNIrS
         /mQX+uH0K7q9Z85U4Zg0+Nhfh9kvQVske4+pMpxH4+noV2FZqhlur1tMARaScb7+swgL
         HP+ymXJohkaaOYNcvpqPxkFjADs7X2By3yuHk3nFAMRciZQP25ZKFHIi79Nzc8Q+sVN7
         /Q2vJvKvy3qgGoi5RquanqEymtWxjCpnToEuU0rIlItKIRSRrLnwjoceRgGbiPKtyY8h
         e7/hrk2T+i2IJfhBSHY1R++kGn+FX0Bhttu1kx/RuUDEPTse+DyMk6Fq8qa6EQC39VoW
         Fz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWumMt67h30adlz6lQSPu1lCC0nb5fEUVVbRzQpjcvo=;
        b=16IbEA985ZfSmQjjOgZPKBuqSU55VIRIQdfpSMB/ePNNZqvSp8dhEpjbFGFWo0QscB
         Uy21xyFpBSkXOKGGc37KZ0ZPmEnfRIoJkLHIqisMCYb+AUAXXxnJ4pSZ401wbLh38Qw5
         ViftVBWsbJBHVwH9QCbIW+UsNQysSjGTAL4BKv9oi0U/HEKBGL6L0ZKpA7rh65bwF4yu
         tVuapYdYNR81ym/liLb7zNRZvabdVVlNPp4axRuJ87Op4KKH0vv+241XhNYWDPjT6/bx
         OhEJ1cL1GALggJVUC3xecEwj/iG+N3nOkjY1maSbhfx3td29dKDqSzuRbs8qR/xB2KBZ
         pSvA==
X-Gm-Message-State: AFqh2kooVOl+r7auWUwhksPxWrZ9BoPLTjjFvHfyutZG8DwPrVAQaLQD
        kwl7YEj7d3UkT6WI9cofd21+skbrHBQwgQ==
X-Google-Smtp-Source: AMrXdXti1lKiCaXlNSRE2JW5nczFpDOhKStlFPEZ4CPRBcdvSua4WfixHLy18+8Z4IvbaX1P92mffA==
X-Received: by 2002:a17:902:ba8b:b0:194:7227:84db with SMTP id k11-20020a170902ba8b00b00194722784dbmr14540982pls.37.1674202858751;
        Fri, 20 Jan 2023 00:20:58 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001948107490csm11422906plh.19.2023.01.20.00.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:20:58 -0800 (PST)
Message-ID: <2c19bec4-c4e7-7ac4-d612-27e531b1a022@gmail.com>
Date:   Fri, 20 Jan 2023 15:20:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: cgroup-v1: wrap charge moving deprecation in
 warning block
Content-Language: en-US
To:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
References: <20230106034836.23708-1-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230106034836.23708-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/6/23 10:48, Bagas Sanjaya wrote:
> Commit 4ddb1a2aa1a3c4 ("docs: cgroup-v1: wrap remaining admonitions in
> admonition blocks") in cgroups tree states that it also wraps charge
> moving deprecation notice in admonition block (specifically warning).
> However, the notice isn't in cgroups tree when the v2 of formatting
> improv series [1] is submitted (and then applied), but rather in mm tree
> instead.
> 
> Wrap the notice to fulfill the intention of referred commit.
> 

Ping?

-- 
An old man doll... just what I always wanted! - Clara

