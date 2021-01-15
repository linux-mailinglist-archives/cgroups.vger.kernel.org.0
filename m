Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1A2F86C6
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 21:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbhAOUfJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 15:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbhAOUfC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 15:35:02 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12FC061793;
        Fri, 15 Jan 2021 12:34:21 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a13so4618718qvv.0;
        Fri, 15 Jan 2021 12:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Buu7vl2DmUxrP1TTcuQeMn3o73cNYpfT6GWTG4kp3LE=;
        b=Pk3q35YTFqdo070RWlImlEVDTrIV4pmBi57xoe113FYc7H0BEAtEw1BbFTF1/8foxF
         8NKdt3a2K3AQpYSOqT6SYHZA/pqzYZmoYGMyq4uNSz3PfRMD/VtVsEQFpVgi5EAKp24Y
         Ut8qu0YjUymjfrDwsFbyxcTqxwtD0O/YlPk1y0od2Yk/ABo1H/OVB1kY+mkOka/SrF2D
         80lI0HvIgtxO5PIzFsp58UohekzHAnYqEFUyGMSXuYHG8w1qtgI37dpOdXkDWZ9gkcxE
         ZewZjASzgaMaZql/dHkB0cHfOoKDvq8wNvBEk2HtOxKmV3GE3s0CZfd+9dT9rzh0Zn/k
         AzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Buu7vl2DmUxrP1TTcuQeMn3o73cNYpfT6GWTG4kp3LE=;
        b=jo0zfqF9nXt4G5FUSkSswCo7LHVc9qF92fsV6vWzSapvbPCpr0JbK5winigBQBkyBN
         h4aFkDpydeP8ci7KWPr62IWz8nX+F3nc4oO8VHkn9PLEPXCyJjtx+8FOvRxrgjdv3jae
         fC4uV6sCXR97fARt1wPcXCQc794qaH3lyh7zMD+e4QS+VCLSXI24rUPUZzJAVizEg6Uc
         isUToqYi//s6WskwKPuk23gWzzlXain8En7n4JsSmF+XjtgyD26GLwXN/8SHm9sxpprX
         P15hNWeL5oNlpndFdzaxnUvHF4/7VbrejHA06HPV4VBFQzOFfx3DkVKvc2B+EZTAqs29
         28Ww==
X-Gm-Message-State: AOAM532Dl4iS/kl1eO2KgnU5o70GR/WmW13i48WkOHfedd+dX1iIy6Uk
        f7X6WmPlvLAY1ECPvdKD8dkSXvb2VQPunQ==
X-Google-Smtp-Source: ABdhPJys2oriE0LKffxi/ZXX5MpIrXn3Wr32kQwI0zoObCQVQe51p3zPPO8EjH18RyJxwyJ2m0LFZg==
X-Received: by 2002:a0c:b64e:: with SMTP id q14mr13776841qvf.52.1610742860921;
        Fri, 15 Jan 2021 12:34:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:97cc])
        by smtp.gmail.com with ESMTPSA id l20sm3484245qki.129.2021.01.15.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:34:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Jan 2021 15:33:35 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan.x@bytedance.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Update my email address
Message-ID: <YAH8Hwq4a3Q171zq@mtj.duckdns.org>
References: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
 <f8fe9c3b-db08-50da-d207-0952be5d2b85@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fe9c3b-db08-50da-d207-0952be5d2b85@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 13, 2021 at 04:59:42PM +0800, Zefan Li wrote:
> Signed-off-by: Zefan Li <lizefan.x@bytedance.com>

Applied 1-2 to cgroup/for-5.11-fixes.

Thanks.

-- 
tejun
