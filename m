Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54787A2539
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjIORz4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 13:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjIORzw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 13:55:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584B10D;
        Fri, 15 Sep 2023 10:55:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c1ff5b741cso22273485ad.2;
        Fri, 15 Sep 2023 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694800547; x=1695405347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaFcn1QzXPssaV1y6SpztPUVojrCHgnKF1dhNtlMGp4=;
        b=gkZvq6P00k5PUTsA89cAMAWHBG2rxmwaEnZaA1Dui3FGpsn8CeB6QBfPyADwkiSNrX
         dqbWmJtalDGj5/icUCkXffvKVzMU2S6nva0A26HdrYFmBs2t7P5B/J2ATtwKiZ1j+MYG
         2kPEGTe/9HLgHjsjCZgEfKkLjbMvACBlDtNVbpg9vRXszJoJgwtrflTxaCtTTA93fR2r
         IfmnBFcvAahdRUryWm17p1BZAbKnWi4jn0bebTAKb1SAbW8UUDySzppGIlEGQbGfuHR3
         BOl30qLJyJiDa5ZRx7N64CdbR1t4IhQX4BiToTfkCEY3EE/iR2Dl5Dn4OH8BNxkjOinm
         RPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694800547; x=1695405347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaFcn1QzXPssaV1y6SpztPUVojrCHgnKF1dhNtlMGp4=;
        b=AXIqjZ5n+L2Ps+A5U21jYrZJqfwfZ7TXLjx1fF3aRv7xc+8mLSoaEFrMTXB9gUOArO
         euKiW1KrifYFzADJMSvWSagfWDrPtUWxAoKRbKLtxFgpnVznHP+KCZUnu6VBac6AJf5k
         Kpr5pTVRPevSncLaX3C3h/JCrxvcdsnRxBr0sHW3dtmSYsSMTWI4G9jV723HosjyWFo1
         2+QrNOGd5WW3n+sb4cIcFN2FZzECcDy5h2JZvgLEnc+jKN/uLvUEpE/zjIc7DgDY1MAe
         qg7lcV+JjcKKY/YoJaEWEV8XuuLmuET9yksqiD8GTeSLhAl1lUoi1glqCoy4uJ/wQpug
         dRCw==
X-Gm-Message-State: AOJu0YysJfybWAhyMOZar3g3YljeD+gP1CUAvcKLGDVW8Zm0fEP+CrkQ
        bc+UBI0pP3pKkNKLe3CivJo=
X-Google-Smtp-Source: AGHT+IGRKGAnyvhP9vrm2smcwDqLMNs/LZm4mYvCnAl2BqNU2eg1F0wc2J6eK1BHRcqsAtUi+Kr87w==
X-Received: by 2002:a17:902:b943:b0:1bc:61d6:5fcc with SMTP id h3-20020a170902b94300b001bc61d65fccmr2096478pls.51.1694800546861;
        Fri, 15 Sep 2023 10:55:46 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b001c3f7fd1ef7sm3780417ple.12.2023.09.15.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:55:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Sep 2023 07:55:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v4 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
Message-ID: <ZQSaoXBg-X4cwFdX@mtj.duckdns.org>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-2-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913040635.28815-2-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 12, 2023 at 09:06:18PM -0700, Haitao Huang wrote:
> @@ -37,6 +37,11 @@ struct misc_res {
>  	u64 max;
>  	atomic64_t usage;
>  	atomic64_t events;
> +
> +	/* per resource callback ops */
> +	int (*misc_cg_alloc)(struct misc_cg *cg);
> +	void (*misc_cg_free)(struct misc_cg *cg);
> +	void (*misc_cg_max_write)(struct misc_cg *cg);

A nit about naming. These are already in misc_res and cgroup_ and cgrp_
prefixes are a lot more common. So, maybe go for sth like cgrp_alloc?

Thanks.

-- 
tejun
