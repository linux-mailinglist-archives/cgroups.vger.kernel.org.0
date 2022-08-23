Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959FE59EAA6
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiHWSMT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHWSLe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 14:11:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA9918B10
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 09:23:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g8so9368831plq.11
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=H+wq+ieg2zAz6Oh265oix+95YnEXxnYHwGzSgbRpnMk=;
        b=dNfh/WFHo74Na+Pm8EFB0Xu+i/XqeeZ2FCpfKC8Bd83OTkRCURk9jf+0QUL822DPd/
         XuVtyk9kGSVJQUQvyB5q/zBXswN6tcZ6HRuAWadsOWHeqI4MzGx2du87v21T74O0v5yo
         YWS5xS9PWKGao6NCMPlde6iVzIphk4vtwRhjKqW7CUh3eoC78c7GqOODwu5xRtW1ct6m
         WMu/ldIPYmvQPapPBRtmSnscHHCn0NrCgKxy8lYwxSMoz7DeBtz0BomQ6cZMaichB8Ik
         QsBocA8vI5I4iIIwroyA6d3YGI8WQdn1C8Il9nirpVRepyBFsaoG083BOeiV/FXvFwsx
         9XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=H+wq+ieg2zAz6Oh265oix+95YnEXxnYHwGzSgbRpnMk=;
        b=PCAbJGjZkLxosKAMDdsNvWxaZGxXuLLBQskUpvBTboU854D/sGNifBo2r9+rsgYBXF
         FZEjlRfUfA5RoP6/ECu3QXPHqdM7W3TX9pjdRN6XYzCfavbjAq+cPvCy++dZpXq3B+pr
         YXkrehAMuPgn7MAZdo9F/rTkB2YYha344nLFrt7Y3dK0kBOVJf4D5QZ7vjZqtKuBi6lv
         9zJSahLOxfNiq00rFn0WY0x7ODnaqXSvq48YKRDRzz6DYGMCTGID7xWl48zK9KYNYhI1
         zJ+E66RkKBaQYcZYZo2mkG6bein8Fs3CCLtxSYUJZlVUmc4n3Y3BPGMzJFvV2OnoZQlK
         mptw==
X-Gm-Message-State: ACgBeo09imYILCtT2dX6hY8zTsLFXUhU5nDGLMyrG8d8ZqtQhcPuqeZg
        1TfcwQU7EXFBjhtQk5Zkhjg=
X-Google-Smtp-Source: AA6agR5R9l0L+PMexU2tdkNbb5lEoousaEllnqGuCrm7p6SSWHu7BEVVjzMKCiT7dRHWf/3MgCNeMA==
X-Received: by 2002:a17:90b:48d0:b0:1fb:3853:b23 with SMTP id li16-20020a17090b48d000b001fb38530b23mr3905508pjb.219.1661271814022;
        Tue, 23 Aug 2022 09:23:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gg24-20020a17090b0a1800b001fb6b179ecdsm1349561pjb.38.2022.08.23.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:23:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 06:23:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Maxim =?utf-8?B?4oCcTUFYUEFJTuKAnQ==?= Makarov 
        <maxpain177@gmail.com>
Cc:     cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: cgroups v2 cpuset partition bug
Message-ID: <YwT/BNqIdCEyUpFR@slm.duckdns.org>
References: <C98773C9-F5ED-4664-BED1-5C03351130D4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C98773C9-F5ED-4664-BED1-5C03351130D4@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc'ing Waiman for visibilty)

On Tue, Aug 23, 2022 at 03:13:30PM +0300, Maxim “MAXPAIN” Makarov wrote:
> Hello. I have no idea where I can ask questions about cgroups v2. I have a problem with cpuset partitions.
> Could you please, check this question?
> https://unix.stackexchange.com/questions/714454/cgroups-v2-cpuset-doesnt-take-an-effect-without-process-restart

-- 
tejun
