Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78C6D2818
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjCaStn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Mar 2023 14:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjCaStm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Mar 2023 14:49:42 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414381EFD6
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 11:49:42 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5416698e889so432394587b3.2
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680288581;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZOhzycB/ed1Cglv3QcQsbmP+PbGJbFYnPnJg8JQRNCg=;
        b=NY4ov3CyjrOGkt3nlM7tThCPwwisGqA9MCueHcb0ox57tn+8OI0jjTFbQ2xNZ0d7U6
         hO6TxL/1I1u8AloYj4zSghmf37darJkgVOGSqlQnDBlMfoJHZliIPNtrCDUlLOeySBEI
         AnsZg2vZ/5CxjsE3LU2AXXHRYU+PHbcNYG1Fatxaqb/7RJ4SfjIbz5yH/Flqf62CNP0H
         yuQHhxms90q//FVf9lGMNcWyPLMDNrYwD2ehzMFNAlZB5GleLTBI4ibKU1ip7kVS0VQg
         zCc14QL5hOvVUiBNbD5PHRSBAMq052WLRCh4ly14jBfSZXUP315widwGI3o9zNOfhu4A
         Cevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288581;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOhzycB/ed1Cglv3QcQsbmP+PbGJbFYnPnJg8JQRNCg=;
        b=q8lWFCZFeIHj8Q4fgQ9jb7JZ6vaX+Ejq/mCCQnxMoXGEIwrfpz0rcviNc1R+5w72LT
         LLHq0+Hdg5DL/dRzxByJXd+/YSuz5qctpOHVusZ42SBRMysBAecWSW2t82wNOhNB7XQA
         UiXJacyusNjRXOJG1kNNdMylCLBmcxoHgEtf2URcib/7QLpWgNRIgx1gWSJRWT5jD3jt
         fT3p39EatvpR0ZLm0TTy7AyGCQDe1CH/kUMq1Qwk57VJxendcLIIHIUtO1pXctUJdUVY
         Q/6NRvkMh7jJcrFiu0CU/4jy3BxuBvfFVhMDju07N/dg9ZNFmmF9rqv0pQhUlCEiMOyH
         mWVw==
X-Gm-Message-State: AAQBX9eruIRAlBnH0rCZYrPltbG9kkN1pBE4YaZHQN69tqfBaggmDvI1
        aZJhvS7kQkNO59waWvB6AaRNrpH8c9ibP+CnmgSypLAEVCE=
X-Google-Smtp-Source: AKy350bUd4JWhN3bz6DbLjlDF8rUf477PqpLRpg3bt341MkjHzh8xN9ewoDEINvLRkaFib3h6SdSla+1x5EEmuVAIlg=
X-Received: by 2002:a81:a805:0:b0:546:6ef:8baf with SMTP id
 f5-20020a81a805000000b0054606ef8bafmr8486053ywh.2.1680288581346; Fri, 31 Mar
 2023 11:49:41 -0700 (PDT)
MIME-Version: 1.0
From:   Tyler Rider <tylerjrider@gmail.com>
Date:   Fri, 31 Mar 2023 11:49:30 -0700
Message-ID: <CAEeXeQLTQjt6O4C-_3dE63gPEgXU9qtdM2+XDxYemV9bsfq_pg@mail.gmail.com>
Subject: freezer cgroups: Forcing frozen memory to swap
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

I've been trying to search for some mechanism(s) to reclaim resident
memory of some frozen applications on a small embedded device. The
typical use case is to bring up an app and once backgrounded/dismissed
the idea is to freeze/thaw for faster resume/restart times.

The issue is that after starting/pausing several of these applications
(and subsequently freezing) memory begins dropping, and memory
thrashing begins. (I can stop the apps of course, but then that leads
to longer load times).

I've already got memory constraint issues, which led to adding a swap
partition. I've tried bumping the memory.swapiness to 100 within a
memory cgroup, and waiting a few seconds for kswapd to kick in before
freezing but since the app is running it only puts a handful of pages
into swap.

Some projects exist (crypopid(2) / CRIU) for dumping the process state
in userspace, but unless I'm missing something, I'd imagine there must
be some existing kernel mechanism (seems like a useful feature for
small memory constrained devices) within the freezer/memory cgroups
that can force all pages of the frozen process to a swap partition,
and restore on thaw.

Does this sort of  cgroup-level S4 (hibernate-to-disk) exist or even
just a mechanism to force a frozen process's pages to swap?

Thanks,
Tyler
