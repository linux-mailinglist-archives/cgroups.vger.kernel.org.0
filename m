Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22D535399
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbiEZSzH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348563AbiEZSzE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 14:55:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4FBCC169;
        Thu, 26 May 2022 11:55:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 137so2029788pgb.5;
        Thu, 26 May 2022 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JdImCzgSPz0H+mIzVDv7OFJ66SmMuOrOg3W+mTgl2b8=;
        b=iyo4DkmN0bT2b6K66vlwNX8B0+jYAq4KpN+s1rvNcR6rzI68koNDIx7pAfkXhb9yPp
         TBZ3zkWl4mgRPOi7Cqc7gKvXu/8HNeQpxnxnY+mjwWqbFI+B/mV8WKWDWdNPLe1xNzix
         ZQNTk2uaN+a4ZPNPSH3SOmTbm6OJTOK24u1x+/0alfhkxLHzOXWZrDf+yrltDPwhayMu
         y5vrXBezGsB26WB2ivlwNSuXP08LsF7yTLW9+zxXlJ0MbwOVY+H3LyPuf+VF/4POoHRu
         8OMZpNMvCITCIJ3qV1bIMAZCUY8O2eSx5+NlqQNqjkmMM+1wmGOMiUVNZk7hJYFKV5iQ
         fJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JdImCzgSPz0H+mIzVDv7OFJ66SmMuOrOg3W+mTgl2b8=;
        b=4pWaAdBaslQAgva20dGbo13FWLWrJfqKKqha2kVe/3FnF1XPCsJqChf/Wu9nzCqBFW
         M+Gx2ksJ8DL24ypc9Hbb9cSOWkNPAYbUMrQfLA3kCoSksha7LXyTt7fHoirTsgVeMN6F
         hPwNYtoUhGsToJUGWT7UEzA7xNbMKHlEpYm0lMiDYGjwu3NYOhUoda1VqPzS7kXuM3QO
         0K3CI16wzebOp5kv+SYQTmsPSr0N87yaR8qRJVVFVBX1tHVmC6SNj3psmTsrml4K/p58
         mDV5GaOtqTrij2tJqVTM9Y36P6X0kGoHvDQhkx/0INI+fKY9ZrvGPt5sekMI/iDlo3Kq
         43sg==
X-Gm-Message-State: AOAM530iiasmxKTEsjjGNlZw70uSrDUf0+LIHbANLzly4DXbqlohgFAk
        TTdYEfPX83w2mcZbdtm/GBI=
X-Google-Smtp-Source: ABdhPJxEI1mid1l84j+LecJ0uD8noGSrwb+fg3wwH5yITMvbO0acen43mKUweAuvykyfeDd6NdjQjQ==
X-Received: by 2002:a63:4758:0:b0:3f6:e04:2ba4 with SMTP id w24-20020a634758000000b003f60e042ba4mr33749043pgk.100.1653591301971;
        Thu, 26 May 2022 11:55:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id 66-20020a621545000000b0051849bc0c23sm1843481pfv.23.2022.05.26.11.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:55:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 08:54:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chen Wandun <chenwandun@huawei.com>, lizefan.x@bytedance.com,
        surenb@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: dont alloc memory for psi by default
Message-ID: <Yo/NAytP6mnmeW2M@slm.duckdns.org>
References: <20220526122656.256274-1-chenwandun@huawei.com>
 <Yo+mXVefsRSxjTMY@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+mXVefsRSxjTMY@cmpxchg.org>
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

On Thu, May 26, 2022 at 12:10:05PM -0400, Johannes Weiner wrote:
> On Thu, May 26, 2022 at 08:26:56PM +0800, Chen Wandun wrote:
> > Memory about struct psi_group is allocated by default for
> > each cgroup even if psi_disabled is true, in this case, these
> > allocated memory is waste, so alloc memory for struct psi_group
> > only when psi_disabled is false.
> > 
> > Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> 
> Looks good to me,
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Tejun, would you mind taking this through the cgroup tree?

Will do once rc1 drops.

Thanks.

-- 
tejun
