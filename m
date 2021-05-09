Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5879C3776C8
	for <lists+cgroups@lfdr.de>; Sun,  9 May 2021 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhEINdm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 May 2021 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhEINdm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 May 2021 09:33:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFDC061573
        for <cgroups@vger.kernel.org>; Sun,  9 May 2021 06:32:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y12so10093556qtx.11
        for <cgroups@vger.kernel.org>; Sun, 09 May 2021 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F49D02pxiMmGycYPdlDKlqkb/EJSemndZuTA7fp/VFQ=;
        b=wBcnT6KuAw/3Cv7Gc32c+74PWGVbiRTsugauRCCtiraGEbkG+/kUK+i8RiSKoUW6eU
         XYrzFUvgUv5fKUwVUzO4heOxy4K2o0TefSwgvoKeJZdogDWcp4/TFObuAk5Icn6ubhOW
         VTAHUPCRQ75E5sZlnfHAx7D8j1dUA+arUu9+UmI6Y9pCHXWVcDVJWmTsYSFi7gfnBhpt
         ckGGRhkdk2lvJz9SjQkKOxPxumTcUqPp+llCbYDaKT5R3Z1hKAGTkucsD27Wlidbn42H
         LaSgPOz2KTNAexGqxgLJSZVbKLFtnjNLi5kU4CsFxumt8vajVSAL92H2WoE2I//+io8S
         ILYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F49D02pxiMmGycYPdlDKlqkb/EJSemndZuTA7fp/VFQ=;
        b=lGxl7uCwo81onqyOiOoi9IFzkPFjnMjIX84YYARU4ujSHpizOqUFsAOd/i6P94sWZp
         W5J1ycfxgbba7QzbaHVx8d5AnwUES2RkHFWMfVm1VOyXPi7VE++25zCmeV41tyF1/un+
         s8GbVTQ4vdX1EP3W7iRA1YtvnmvM+CEKHKhdi61jPIa1W8UKYzu5aFHzv2VFatYWRtQx
         BMFDr0GxGzfYhKyJDxZkpNK9uUPABt/E/L45i2TKAe9zKJ+KD+H4JBIGnYkkDvHBLBQM
         yC6/dy1T4aulmY5DQzgN4aqCnjgtV99VZo+k01+7L8Pf9Yb3McdBmdIgOp0AjIVfQaRF
         OltQ==
X-Gm-Message-State: AOAM530B3R39MxzyLH7LlKuWZfGHYxO6+oRZ54DIISTx9/7XiS/j8R8a
        DCuSu/FdvnWLQp9JVcxwnDSOHwYKTtqLevWHoQuNWt5jq+S//Nxo
X-Google-Smtp-Source: ABdhPJwbV1hPoG0EakaIkyXiCFqPB41iJVvyUPBuniVuTAh0o4+fvXq1pAAyfj2+TdtYXG/AxUXyuCcMy9n7lsawW10=
X-Received: by 2002:a05:622a:588:: with SMTP id c8mr8865054qtb.49.1620567158642;
 Sun, 09 May 2021 06:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <0102017951491312-b3c91c35-577a-466c-965b-fa004d314980-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102017951491312-b3c91c35-577a-466c-965b-fa004d314980-000000@eu-west-1.amazonses.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Sun, 9 May 2021 15:32:02 +0200
Message-ID: <CAFpoUr3WX25TjT9hRtmbSaJ7ttDePGxSGuDjJcs2bhOGe3o_=A@mail.gmail.com>
Subject: Re: v2 cpu.max question
To:     Patrick Reader <_@pxeger.com>
Cc:     "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,


s=C3=B8n. 9. mai 2021 kl. 15:20 skrev Patrick Reader <_@pxeger.com>:
> "the group may consume upto $MAX in each $PERIOD duration". But $MAX what=
? Microseconds? Clock cycles? Arbitrary CPU scheduling units with only a re=
lative meaning? Elephants? At the moment I don't know what values are sensi=
ble to set here.

Those numbers are in microseconds.

If you look at the "conventions" sections of the cgroup v2 docs [0],
it states; "The default time unit is microseconds. If a different unit
is ever used, an explicit unit suffix must be present."

[0]: https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#conv=
entions

Thanks,
Odin
