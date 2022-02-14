Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842C4B5AC8
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiBNT5p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 14:57:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiBNT5o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 14:57:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5E81375AC;
        Mon, 14 Feb 2022 11:57:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u5so184508ple.3;
        Mon, 14 Feb 2022 11:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faMCUXgtmx+3AXg49JAI78UUXqy95249g9sm+/df9gg=;
        b=U1A+Bb18rPgucS1CdIquKO/KQlC0eR27NKxSUImY8Oiy7D1wNhaId2KoUHB4btYKEU
         4u9Zjg2eEAKHQ5kHwKidGlgPI8du5J16z8F+sJNHr6Uj2ZVwdwXJqvgp42B7LBkHCpLx
         fNsVnT2Gql7nO2NdBASFWTya/UuczDhwp9ARH9586d51DW8lEZyTnCfiXIfX1WYapWOE
         GeJhsm3lrs67uSDfIXrlZ1Pf7MRr5EXBs0AUNlNK+7KuWL5jxyEP+eaDXzmgQ6WOcWcS
         c73Yf/mPhRfRVhubGjsd9Yc1/pEuF8KVnxRvakBP5HkToeXTv1SCmGYbuc43TkrLsQRI
         zsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=faMCUXgtmx+3AXg49JAI78UUXqy95249g9sm+/df9gg=;
        b=Z68GLA3IWjogcmQjxZVXMzZrER/4jqKKoRU+CaiTCIAU69rNUeqO0865+5M+dOP7VY
         E473qWv80eJz9R4R6kr1GePkwiXaLIQqsZkeF3j0t8HOOpC8SbdRSyoBAYuacCBJxNSr
         o7Da0y73sWj+vBdKju4wdsRn3BtbmvaFyXj+ON6gfJdJA8XhyYGfiIwwJDmwzuuCNvrB
         sbHMB54DVAAyU84pL30MgDykzEP3XAGft/YEqRVN0s4P/xqSbziGLgMHeh6EIT8NpXFD
         AyyAEGskzn63eT3wZtaK4S8z3Z16mL9F4S2hED3KziY+HQQCuj8s7kJCkKnnlaLD3pdp
         Psbw==
X-Gm-Message-State: AOAM530qFsQO/sMvWkknidWCE+ocymo8sfjBqgDu/fU9DNrgWIbteHfe
        I1GNyTU46+jSyYE53eXcDsiR+7/mgJ4=
X-Google-Smtp-Source: ABdhPJzskEVgewovivQ93Yqm7pSL4EIc60jw8YJ4dfnBLxmZUnSxdbyKGDwkIVVRUcEgmSDV1Gt4LQ==
X-Received: by 2002:a05:6a00:1c42:: with SMTP id s2mr343232pfw.3.1644866602102;
        Mon, 14 Feb 2022 11:23:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g19sm19524769pfc.109.2022.02.14.11.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:23:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 09:23:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC v2 0/6] Proposal for a GPU cgroup controller
Message-ID: <YgqsKHS0wbZFrDkO@slm.duckdns.org>
References: <20220211161831.3493782-1-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211161831.3493782-1-tjmercier@google.com>
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

Hello,

On Fri, Feb 11, 2022 at 04:18:23PM +0000, T.J. Mercier wrote:
> The GPU/DRM cgroup controller came into being when a consensus[1]
> was reached that the resources it tracked were unsuitable to be integrated
> into memcg. Originally, the proposed controller was specific to the DRM
> subsystem and was intended to track GEM buffers and GPU-specific
> resources[2]. In order to help establish a unified memory accounting model
> for all GPU and all related subsystems, Daniel Vetter put forth a
> suggestion to move it out of the DRM subsystem so that it can be used by
> other DMA-BUF exporters as well[3]. This RFC proposes an interface that
> does the same.
> 
> [1]: https://patchwork.kernel.org/project/dri-devel/cover/20190501140438.9506-1-brian.welty@intel.com/#22624705
> [2]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@intel.com/
> [3]: https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/

IIRC, the only consensus was that it needs to be a separate controller and
folks had trouble agreeing on resource types, control mechanism and
interface. Imma keep an eye on how the discussion develops among GPU folks.
Please feel free to ping if there's an area my input may be useful.

Thanks.

-- 
tejun
