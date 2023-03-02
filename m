Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7F6A882C
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCBR7C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 12:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBR7B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 12:59:01 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60B3250E
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 09:58:59 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id m4so75143qvq.3
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1677779939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPFA+ANTHDEBDLlZRcRzWYR3HIDFousSy5BF6H/rVWk=;
        b=naATl86IWiASMsZEMEtqQ+PD07Qk9nnv5YUVcaW9FQIJfbmh/SqrKAZaAlTStOXBfs
         VpyJQjWkV1J7R9kthjOZdY/Li2litcV+POzFGN5H+fy2Y+QgqhNWcBXzsZLVVNfsTfXl
         xVxQ4YLBBlAJB8mZiu72uw0Jcs68wd8oAFrs9UOpmVFgBLp9oGQEB4H1aTC5ImPGaNMI
         QmD5pw9MRANsc6w3P7ZBQb4/izMDCzPX+WYFfuP5NgTpwOvThB8vj+H8kDO3pgw2BoME
         71dhCM5qsABYq5QZ7pUSshDg0IMq81sR9yvhpSZiXSz7SNr51GPtJzSl2czZCB1tl81s
         RP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677779939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPFA+ANTHDEBDLlZRcRzWYR3HIDFousSy5BF6H/rVWk=;
        b=QGXqdw+GQA1H7xSr6XTAnmwOipZMBZKf0kYzi+vrBBJ+D6ramazsAq5KEce+FBzucH
         OMiWGFRBULgZT4PB0Rh9U5QV17k9joxO3uU9tUFpnP1SD53OSBtKm+B157UZbMW3M40o
         D3JCw5Yj3huQzDVoanRb3GxdTm/HU+hBuEvR8ukjdzc50Vb8/7HKZwDu0mupmUUX7z1D
         uv1lH9y+OvRYyus47/69Ws5BpzRBkimAb6nozFSYeXogQMZrWzfLEhWS1SwaJ3gopzg8
         4Wi5ykuyD/ZN41+JvO2Edclb+gUI15AeNyfMjD+RR3EHz+acr7fBK4XvhCY8dFRUa/tE
         cWxQ==
X-Gm-Message-State: AO0yUKW2AXyZDXM0ltKvth2pEi7eiPeTb0CGqZAbLSh+IeSZvQa8awPk
        VKvZ8cBshdlx/0+aRskMtv/xyQ==
X-Google-Smtp-Source: AK7set+paF+Pqf/e2YzrNVugGgZIGX/naMYWpQ7Yrxf6nOwBA/wPtgfnFsGGM3Ce2R4segpcwmHMXg==
X-Received: by 2002:ad4:5745:0:b0:56e:ab31:199d with SMTP id q5-20020ad45745000000b0056eab31199dmr22633759qvx.40.1677779938798;
        Thu, 02 Mar 2023 09:58:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:19d])
        by smtp.gmail.com with ESMTPSA id c133-20020ae9ed8b000000b0074280fc7bd8sm93896qkg.60.2023.03.02.09.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 09:58:58 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:58:57 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, tj@kernel.org,
        lizefan.x@bytedance.com, peterz@infradead.org, johunt@akamai.com,
        keescook@chromium.org, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for
 triggers
Message-ID: <ZADj4YX4uftK/Frh@cmpxchg.org>
References: <20230301193403.1507484-1-surenb@google.com>
 <Y/+wlg5L8A1iebya@cmpxchg.org>
 <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
 <ZADBCEk68W1aGJAV@cmpxchg.org>
 <CAJuCfpHF=9Dv_Yzph5jNmR1ZfTf7Lf=_oShztyLUq0ps_D=osQ@mail.gmail.com>
 <ZADf27Kx5mbFev+I@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADf27Kx5mbFev+I@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 02, 2023 at 06:41:47PM +0100, Michal Hocko wrote:
> On Thu 02-03-23 08:13:54, Suren Baghdasaryan wrote:
> [...]
> > Let's roll this check without additional changes and then consolidate
> > the checking inside psi_trigger_create() in a separate patch. If
> > anybody objects to the late permission check we will just revert that
> > last change without affecting anything else.
> 
> Permissions checks at write time are problematic because userspace
> cannot drop privileges. Also I think it would be an antipattern for how
> we do this in general. 

The permissions can be checked against opener privileges through
file->f_cred. This allows dropping privileges, as well as passing the
fd to a trusted but unprivileged process to delegate trigger setup.

I agree with keeping it in open() for now. But it will matter when we
distinguish between privileged and unprivileged trigger parameters.
