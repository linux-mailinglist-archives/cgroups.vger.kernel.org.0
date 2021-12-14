Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237CF4739A2
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 01:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhLNAgI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 19:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbhLNAgH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 19:36:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDDC061574;
        Mon, 13 Dec 2021 16:36:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so57174841edq.7;
        Mon, 13 Dec 2021 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6D7bydG+h+WxA2aq/kFkeCmdgG2RGXOzUIul9d5/ow=;
        b=JRH8+qRZGG1TG8wzZBp+RioBZjOczlUTjlWMxmj/jw3xIISIHAfwyQt4CBGMQ3NVod
         1rwrPMe61hRHJb7rFMJalTnGJ5snPSd9HGjCC2UcHpD7TiM5Y6ns3fIzLK1IdIibKlsW
         cU2+eYUfJwOQIg0D3Dc7+8CN8luvAG6JDYS1/dmlSfdx4DthfUW0rHSoQLC0w5ZyBsAa
         8AnLOt1NMUlrB54aCCcD8sBi+f2NF9qQqEWBqw2iz3K1SZeZ6AxqM7KKrD/vLzrmpa7E
         WcY0iW4KsFKMYsO9DmogO3CaXaL9JNU0Jf9xFJ3Jr0ZRaTMbpiLNWpNwGxRQ1Hxoi5/s
         zvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6D7bydG+h+WxA2aq/kFkeCmdgG2RGXOzUIul9d5/ow=;
        b=NpzZcai3ecLSUy1W6OOLL1EJe3+JPHPMXqpqj7qRDOPzHwlGN6VrWYgv+eE0zTzdZv
         YoWogZwF+cDuK5Z3qqEWLhdL2WDt5t1+bjCpJemBccJ0yOnQ+oaXbErsaH/hi9w8VCu4
         K53ui0wfQ55lPekmO0qnA9+B3dYIUoTo0rGtR5MTcjLECEMZUwFnNSPfeAFgjRTHWAn3
         yQZrNnZ3pTmN8uh3lLU//QKKpAtA3gsKCz9e9BdjIxeoS51T372U9smR0U7Qh5aon3z2
         Wuii2l7GRPcoQzdM5hqMmeTwftajqOozxsKT0udEwpfJncxkiOt8pHom+kXwh+O3Ax1d
         /Yjw==
X-Gm-Message-State: AOAM532Kn1RXRzKvuQVXdQpmbigkWIyMeV4G0Xke0PkOqyiFRq71/s5h
        2Ur+2MV770QfI6xvtUffutw=
X-Google-Smtp-Source: ABdhPJwdU8ZOUq/Yq5QNPcewxe4BAFQMhNQFawzNAFm04NfL5Q0DgxMNIeGlVudOtTERg4LjzSjnbQ==
X-Received: by 2002:a17:907:9607:: with SMTP id gb7mr1941489ejc.441.1639442165391;
        Mon, 13 Dec 2021 16:36:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id lv19sm6549132ejb.54.2021.12.13.16.36.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Dec 2021 16:36:04 -0800 (PST)
Date:   Tue, 14 Dec 2021 00:36:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: return early if it is already on preloaded list
Message-ID: <20211214003604.mvmqg4i4zj2t4toq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20211211161729.10581-1-richard.weiyang@gmail.com>
 <YbeekNeegXoP6F93@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbeekNeegXoP6F93@slm.duckdns.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 13, 2021 at 09:27:12AM -1000, Tejun Heo wrote:
>On Sat, Dec 11, 2021 at 04:17:29PM +0000, Wei Yang wrote:
>> If it is already on preloaded list, this means we have already setup
>> this cset properly for migration.
>> 
>> Let's skip this cset on this condition.
>
>The patch looks fine but I think description can be improved. Can you just
>say that it's just relocating the root cgrp lookup which isn't used anyway
>when the cset is already on the preloaded list?
>

Sure, let me try to rephrase it :-)

>Thanks.
>
>-- 
>tejun

-- 
Wei Yang
Help you, Help me
