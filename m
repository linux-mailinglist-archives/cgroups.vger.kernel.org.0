Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D77D76A0A7
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGaStj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGaSti (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 14:49:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C11101
        for <cgroups@vger.kernel.org>; Mon, 31 Jul 2023 11:49:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31765792c7cso5149550f8f.0
        for <cgroups@vger.kernel.org>; Mon, 31 Jul 2023 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690829375; x=1691434175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSrMC3+SJ0egYG0f2gwoLknFT0dgY+FAasCFfQTvvxk=;
        b=TPZP/yMbUeQTiuSSmHPaXqzypxoYzjL9bpLQpl0sY8BgdmcRkvH9tlSaOBGz+GX6Rw
         r7vFIC1zKA9ozOF6N2GPcB4UABRxXkHaRMY4XC4SVCpUl6dpAGWvWd5MVy3+9ZC0O4yV
         65rxWUeZOu5KUypxo2o9f9h4X+VtKC6wRMJ6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829375; x=1691434175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSrMC3+SJ0egYG0f2gwoLknFT0dgY+FAasCFfQTvvxk=;
        b=QDsKaQGnSvc9ZFyQLMrViYlw9wMF2b//e68hnAMgjM0u79lFtXVas8LA4TxeFFaNDV
         4GlOB9B3C5n1/vcymWhSuJLBsj623K4xTBgLDCkoySvwhKP20EKOAF/6yk0F9AH76lJE
         BASDti1JrPlcDJG4kLZN4IcVWhCU5yCo+9aMNWcaFx6qleNIXrJR3Rja1EYHFWGtxzc4
         V2N02pn1JOjb9W9k1HBgqoCZGGydFFwfBc0OgYuN+l5gT2NNd8Zvpj92AD4EdvcUY3LW
         Wr5tjIov3QanpVJsrfmARKu21tYOOhX8VXcwioOG/TBTn+xwrWtV47GXZmtoe1cMsHo/
         WV4A==
X-Gm-Message-State: ABy/qLYF6SnMZNnoOnhcbN1JYQvJHcFY9wE4iYWcOmMYXwW+5D4qa2Yd
        3Wra0k2dRCaPr6NtWL06GQPaoh0afQ13tOorCWZqkw==
X-Google-Smtp-Source: APBJJlG8lpE2Wep4n8q70FSDhNYglqbro4R4N+ED2lPckUBzblETeT3zfGStQ8Fmi6wsQImptsOjPaXADGtytwcF2v8=
X-Received: by 2002:adf:ec0d:0:b0:314:3b9c:f02f with SMTP id
 x13-20020adfec0d000000b003143b9cf02fmr463450wrn.49.1690829375213; Mon, 31 Jul
 2023 11:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com> <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
 <CAOQ4uxiFhkSM2pSNLCE6cLz6mhYOvk5D7vDsghVTqy9cDqeqew@mail.gmail.com> <20230731134615.delje45enx3tkyco@quack3>
In-Reply-To: <20230731134615.delje45enx3tkyco@quack3>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 31 Jul 2023 11:49:24 -0700
Message-ID: <CABWYdi3s35QZXSeb95XUeLyOkM66po603-ows1n3np=Lt4g1nw@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 31, 2023 at 6:46=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > I agree. I think it was a good decision.
> > I have some followup questions though.
> >
> > I guess your use case cares about the creation of cgroups?
> > as long as the only way to create a cgroup is via vfs
> > vfs_mkdir() -> ... cgroup_mkdir()
> > fsnotify_mkdir() will be called.
> > Is that a correct statement?
> > Because if not, then explicit fsnotify_mkdir() calls may be needed
> > similar to tracefs/debugfs.
> >
> > I don't think that the statement holds for dieing cgroups,
> > so explicit fsnotify_rmdir() are almost certainly needed to make
> > inotify/fanotify monitoring on cgroups complete.
>
> Yeah, as Ivan writes, we should already have all that is needed to
> generate CREATE and DELETE events for the cgroup filesystem. In theory
> inotify or fanotify for inodes could be already used with cgroupfs now.
> Thus I have no objection to providing fsid for it so that filesystem-wide
> notifications can be used for it as well. Feel free to add:
>
> Acked-by: Jan Kara <jack@suse.cz>
>
> to your patch.

Thank you, I just sent v2:

* https://lore.kernel.org/linux-fsdevel/20230731184731.64568-1-ivan@cloudfl=
are.com/
