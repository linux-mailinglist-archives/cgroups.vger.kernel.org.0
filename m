Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07777243D5
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjFFNKP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Jun 2023 09:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFFNKO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Jun 2023 09:10:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646381735;
        Tue,  6 Jun 2023 06:09:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75d4aa85303so254186485a.2;
        Tue, 06 Jun 2023 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686056993; x=1688648993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33ubNGnlWzb0zUgKXOo7PameOxfWs466JIL20ejCxRU=;
        b=YLInumMaJo4nCJrIXzReQU0BlvN7m/0+3WtFgkqlPKn6GyR1fIwy2krQvMzHNjBGH1
         Y68DUYUasgdDYG/uqY+QQR0cx+AWlJ90UMPDSrj03K7ZPH/Vcg+7r/ioR4jNrittWwJV
         OWXP2/8dAEQaaQnInokesrQdcEBGKe0kDdwzHAOP972bTAcmV3T0+h9xvzx/JmmslsqT
         WyYU75DQR0D7ifiPW7k56WL7/LxxgAn5oHOrj6CtGzvZpuIl0Hoo169ua5O1ja5QvQvo
         +mKDM5pGvxu/FO4dEtgsRgQq8OX00FRaGyrOm/XI0oC/+XGwwQ1XXsu/XVNuyfhRCFnr
         Lfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056993; x=1688648993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33ubNGnlWzb0zUgKXOo7PameOxfWs466JIL20ejCxRU=;
        b=VTPj7K7Rfj14hEdtTxQdjP7KApoJKXQO8zThgVT3YegnCHZskpS0ZeV3YBCxUTjLdO
         FLdtO1np+T9XY/F+cG8/jB/lU3XsAVT793Zmq4VsrIKGhU/wemhKGmHwGkcAVzgZrz2v
         O+tIykCafhUUDouTh+OKGbZsS6vwoHsIjaVdVBGfe5JWh+TKCz0b5T6fBlcHlK9wlevM
         NA8a0ci3pQ7V9OURI2IE4eggRkJ1jkEvBSQdWiU90PxqGyIkRjokAmt6OK8vEnev3b76
         sQUeiXI5aSwV6cm7f/fPFWJaKtT1E5oW+uAv6ZplYE5XcA04b4Nf4IMLJ4Xg3dY2zSM0
         WTdA==
X-Gm-Message-State: AC+VfDwanVri0pw0ecMaA/fL2eM7ZL7kjQ8RSLyrVjxZWONxwfI9WkaW
        FqQpUeHsVFmCgWDqqmNlxNAourkHPJeQng==
X-Google-Smtp-Source: ACHHUZ5wqKztZBRaznjkUEdJsWrdECyI9l14LFbb7jqQUw5Lqd69wkHR6kktGC79O0E7d+ApAmNjiQ==
X-Received: by 2002:a05:6214:2269:b0:626:2047:c845 with SMTP id gs9-20020a056214226900b006262047c845mr2541061qvb.55.1686056992800;
        Tue, 06 Jun 2023 06:09:52 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:400::5:eed0])
        by smtp.gmail.com with ESMTPSA id px8-20020a056214050800b0061b63237be3sm5358299qvb.131.2023.06.06.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:09:52 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:09:50 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Clarify usage of memory limits
Message-ID: <ZH8wHva5/8n1EJv0@dschatzberg-fedora-PC0Y6AEN>
References: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
 <ZH55K79CaSD6Zya1@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH55K79CaSD6Zya1@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 05, 2023 at 02:09:15PM -1000, Tejun Heo wrote:
> Hello,
>
> ...
> 
> I think it'd be helpful to provide pointers to oomd and systemd's
> implementation of it here.

Yeah, I considered that but didn't see any other external links in
this doc, so it felt out of place. I don't feel strongly, but feel
free to add to the patch and link to oomd
(https://github.com/facebookincubator/oomd) and systemd-oomd
(https://www.freedesktop.org/software/systemd/man/systemd-oomd.service.html)
