Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26D4122FC6
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLQPJg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:09:36 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33444 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfLQPJf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:09:35 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so4307713qvn.0
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 07:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0OkMwroxaFTIfHX5v7BwxiXC57WOkvd1SruP9P6F2gQ=;
        b=AqbMRymX9CPH4mO3hD6Uyz9s6YZsLavTX4LxKYda/0ELAak4kzRE/RPLbedix3FfB0
         iMU1mgu77Wqy0j6Psmm6DAK2UifEGoCWvQkAdq0VDBDHBCGfYG8T0kBkkTEsN0g17kV3
         8EbFihrTBwEGteAhyplEHTnvjYsRUIDBoj5hS4K4q124bMhSAJotdOEjqgfDlUgFjOPF
         23cIZboMOWo821f2gNCNtFM5cbbe/0QbiTU2VKtAItwRPgpSOLR44cx5UjESNPh+Q8Dv
         jbdD8EQ+hwNjT09z+o9vDTcAnTa1GdT4TGp05AaKX5pCPe8xB6IPgMYE5tZY9pBSJC8O
         eh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0OkMwroxaFTIfHX5v7BwxiXC57WOkvd1SruP9P6F2gQ=;
        b=l/nScrJLqt+wqTx5IxCHg5dgV4a1TR8LCDz0PhQ36Z9l7/ht/JUdA6VyfGXXr+uU2z
         LuFbnFLzafm7rhGpr/FXxxsBHaWrYLnkiE0yIQ4lmjJkh+ULtlf/rS0wIOA5bG+ZSOHN
         6/qWWBGv9HLL0cM7myoo0KE6mu7+Isi+EgWv1ydclMPjN6SiPmjHcEk7deQI7Os8uXzX
         U8odLv4c14zjmJGcockvJXwK2t7Elplnw5rYM+A/GQgPfO0XP9YQLvRqQcs9ZY5OtU/S
         xMhGO8pmeAdmAYC0diP2/3b8/0S8R/zcXEgX0ZaP84YDnKeCmXgm9ZsiV6ymgZ/zdYQz
         /mqA==
X-Gm-Message-State: APjAAAXPIgSBAu2D1tT4NCP9J8dw0QVjs7n3If5BI3TP7KiMWU9XzFSw
        tnkB+Ok6aHeNayQ0mok+nnmEMA==
X-Google-Smtp-Source: APXvYqywK6ioDEXZv5myk3NMkzoATz7qETU5xLGU5chMhRL1F3ITK58LT6S9ttP9tEzds/UoMxL0nA==
X-Received: by 2002:a0c:f703:: with SMTP id w3mr5069817qvn.6.1576595374810;
        Tue, 17 Dec 2019 07:09:34 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm7055010qke.85.2019.12.17.07.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:09:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:09:33 -0500
Message-Id: <5D853968-99FD-4B66-9784-C1C540B23F92@lca.pw>
References: <20191217143720.GB131030@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217143720.GB131030@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: iPhone Mail (17C54)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Dec 17, 2019, at 9:37 AM, Chris Down <chris@chrisdown.name> wrote:
>=20
> I struggle to imagine a real issue this would catch that wouldn't already b=
e caught by other means. If it's just the risks of dead code, that seems equ=
ally risky as taking time away from reviewers.

Hate to say this but ignore unrealistic configs compiling test should not ta=
ke that much time.=
