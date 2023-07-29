Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E51767C13
	for <lists+cgroups@lfdr.de>; Sat, 29 Jul 2023 06:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjG2EVA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Jul 2023 00:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjG2EU7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Jul 2023 00:20:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72B49D8
        for <cgroups@vger.kernel.org>; Fri, 28 Jul 2023 21:20:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26826f93a1fso1867839a91.3
        for <cgroups@vger.kernel.org>; Fri, 28 Jul 2023 21:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690604458; x=1691209258;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE5l1VpxCufAhFhvUtJmOdSBkyXi7tvoVHorDEIVEKk=;
        b=eTKPFzDVlCVCD729YC/fNARpxPKJmbcKPJ5PrqHLuFkrQTAnFQX5I9vYbnumWFLxo9
         LfZmeokE3Nvt6VZqUeB2mVqDIQPPUpj8h8K3Ib4HIgsBmxnKIjcMl5R6fZnP9pbv9WIb
         fy/60rGbGHnw+fNoIRQM3Lgo7qLs/VNO5ld/sxEwIFpoUnmv3X1eZJj5tN4xlEVhfMO6
         5HgtxBuBksxWlh3i4kyh9DjYnkG84wtUIZ0LG15o+cZ8qiNqiCTBabazN8lOVZMXoL7g
         1Lic4c4THtv68N/pvhNcezlqoFZ7kZk67/blS/OBK2g/aj/oeyCm9oAW1+hJlS1tWglT
         7TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690604458; x=1691209258;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE5l1VpxCufAhFhvUtJmOdSBkyXi7tvoVHorDEIVEKk=;
        b=ea1+2xztw3rFulfdweXvv93qdOWWTbMNT9SqWx7PXFovUNZEKK3mk9524El9ngM+Br
         H+4XLxrS1rQolEO676iGIVK0JwBDKKYQmfHsHL4JgMrxpd7WJH1YXmXdJJxL+hLMO0dL
         21uCk6hGReiW3tgJfYEBnXV1BsnSZ8iuYp91KHGi5bk+qO4AkqbiXj/nU0iBgFr6E5Vu
         TAjrNIASAu4QqNAwcMj0LTmO75szxYI9fJn3/13A9G5R7E613Hu9yq0q4l75xezaF41+
         ptv5x19t/vektjyT5UskfTOz1wSZg1hnTBjs/hd9DYSWvEer5xY58mBWb8dEtU7r8QyT
         NNyw==
X-Gm-Message-State: ABy/qLaUWppfXrrOqRFdU4/xLgFT9Gv8wIEr7QRpcwhJI4cEhRzWcXGb
        fXLnGUlsrqAjVbkUs37Ou7GKNvJ3515DNNgHyfg=
X-Google-Smtp-Source: APBJJlEzDUVH3bG0XLXttbNNEQmE5FQiSuHoieI5nYnbFR4cDbVY6PWgmr14GPXLmlGOQBeqUBCh7/4Efx5Q8JuBcNY=
X-Received: by 2002:a17:90a:fa54:b0:262:ea57:43f with SMTP id
 dt20-20020a17090afa5400b00262ea57043fmr3613209pjb.37.1690604457724; Fri, 28
 Jul 2023 21:20:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:7b99:b0:d3:811f:e55d with HTTP; Fri, 28 Jul 2023
 21:20:57 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   BINTU FELICIA <felicia712@gmail.com>
Date:   Sat, 29 Jul 2023 05:20:57 +0100
Message-ID: <CALG3m0FrePQqaPEgGCPFtjcfBHrGi5LrsgaZ9VUECQEccx_UrA@mail.gmail.com>
Subject: HELLO,.....
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail,
with a wish for much happiness.

Warm regards,

Felicia Bintu
