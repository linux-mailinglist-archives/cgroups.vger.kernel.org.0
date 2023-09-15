Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607327A253D
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjIOR6g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjIOR6T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 13:58:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99C10D;
        Fri, 15 Sep 2023 10:58:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c44c0f9138so1393035ad.2;
        Fri, 15 Sep 2023 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694800694; x=1695405494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmdT62MLeEsA6axk7W0K2pDhI35EHOQeEKc3uSsgrQ0=;
        b=hZuXMt1J3dQIPEM02Z4526qVSrcu3LkoUQ3N27PorLBdZ14WEh4V0cFMEFrbbyDQ75
         USKcvjmgTEVSwV12oJtSKokKx9B3+rsh2WRMSbWPLpLy3aolTxoDvGFUDhpAa9wjlgAJ
         lrUpK5VDuodvZxhrk690IjivVlyzS3YxOVKMakW5nM/bpp+gMG/RYT5BabsvGXv85O/F
         oDhJDhyUUERxrFMUHQIigoSo4Nu+vyGwlciTkWrfSdgqfjyMef9pa9WSkYecy/6XwDT2
         jgs/OlN5s55OfrvjKZGQ4KGuNrpnlWJx4R+duIVhETvCIXh8PlFvP6On0gSM+6bnZpw3
         Rnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694800694; x=1695405494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmdT62MLeEsA6axk7W0K2pDhI35EHOQeEKc3uSsgrQ0=;
        b=wRW8ArU2JHWBjZe2kNfwX3KLYtMxwljvAwh+XNaPQ+4xk6k36NBCQZvkzXjzUPQGPT
         8YZb12ELLzRGCiHov740af4si/9bOfpvQhiaEg/a+k3QKXz3nPZWMQ37+l/XMueFtyrC
         6QP/Lpj06tc0rw0t5qRf2ITqeSwcOF+WqjFWXMMRXEsZLbv4MBgM69gKYtXbkh90/Z8c
         Z050GU8APMf1j/bws9Asv06yQV56qr5a8oxIUDk83p2BDB5/OIXJ0FbzQomefdl190Ez
         cM/nr5+x+ItawPM4bpDcXhOHBwYdGiB3xgtLNQBvoZxpnx8KwT/WJXHRxRpdQCl5yW7M
         smPQ==
X-Gm-Message-State: AOJu0YzDHXwk81qybe7Dvpel/yxJHAPSXkX24aPhdwyAohLHonCFSPvC
        bqHOacRF50Ke7Sl9mFndnk0NY63lQ3b6LA==
X-Google-Smtp-Source: AGHT+IE4zEUkV7iAX8li6H1844OYAVO6n++R9UUl9kws075PdsKy+RdBOleZQhtiyIl4yj8Lhi19RQ==
X-Received: by 2002:a17:902:c1c9:b0:1c3:ebfc:5198 with SMTP id c9-20020a170902c1c900b001c3ebfc5198mr1970771plc.11.1694800693925;
        Fri, 15 Sep 2023 10:58:13 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001a183ade911sm3774119plr.56.2023.09.15.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:58:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Sep 2023 07:58:11 -1000
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
Message-ID: <ZQSbM9ItXVyeIU7F@mtj.duckdns.org>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-2-haitao.huang@linux.intel.com>
 <ZQSaoXBg-X4cwFdX@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSaoXBg-X4cwFdX@mtj.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 15, 2023 at 07:55:45AM -1000, Tejun Heo wrote:
> On Tue, Sep 12, 2023 at 09:06:18PM -0700, Haitao Huang wrote:
> > @@ -37,6 +37,11 @@ struct misc_res {
> >  	u64 max;
> >  	atomic64_t usage;
> >  	atomic64_t events;
> > +
> > +	/* per resource callback ops */
> > +	int (*misc_cg_alloc)(struct misc_cg *cg);
> > +	void (*misc_cg_free)(struct misc_cg *cg);
> > +	void (*misc_cg_max_write)(struct misc_cg *cg);
> 
> A nit about naming. These are already in misc_res and cgroup_ and cgrp_
> prefixes are a lot more common. So, maybe go for sth like cgrp_alloc?

Ah, never mind about the prefix part. misc is using cg_ prefix widely
already.

Thanks.

-- 
tejun
